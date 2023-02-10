import { FastifyPluginAsync } from 'fastify'
import WebSocketPool from '../services/WebSocketPool'
import WebSocket from 'ws'
import { getProxyUrl, getRelays } from '../services/env'

const root: FastifyPluginAsync = async (fastify, opts): Promise<void> => {

  fastify.route({
    method: 'GET',
    url: '/',
    handler: (_, reply) => {
      const relays = getRelays()
      const connected = WebSocketPool.getRelays()
      const disconnected = [relays, connected].reduce((a, b) => a.filter(c => !b.includes(c)))
      const total = relays.length
      const proxyUrl = getProxyUrl()
      reply.view("/index.ejs", { connected, disconnected, total, proxyUrl });
    },
    wsHandler: (connection, _) => {
      connection.socket.on('message', (message: WebSocket.RawData) => {
        WebSocketPool.broadcast(message.toString(), connection.socket)
      })
      WebSocketPool.on('message', (message: string) => {
        connection.socket.send(message)
      })
    }
  })

}

export default root;