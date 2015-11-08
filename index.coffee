NEIGHBORS = [
  [ 0, 1]
  [ 0,-1]
  [ 1, 0]
  [-1, 0]
]

module.exports =
  class AStar
    constructor: (@grid)->

    path: (start, dest, opts={})->
      start.distance = @distance start, dest
      start.cost = 0
      stack = [start]
      closed = {}
      closed[start] = false
      previous = null
      closest = start
      max = opts.max or Infinity
      deadzone = opts.deadzone or 0

      count = 0
      while stack.length
        node = stack.pop()
        previous = node
        closest = node if node.distance < closest.distance

        nodes = @neighbors node
          .filter (n)->
            node.cost < max and not closed[n]?
          .map (n)=>
            closed[n] = node
            n.cost = node.cost + 1
            n.distance = @distance n, dest
            n

        stack = stack
          .concat nodes
          .sort (b, a)->
            a.distance + a.cost * 2 - b.distance - b.cost * 2

        return @makePath closed, node if deadzone >= @distance node, dest

      @makePath closed, closest


    checkBounds: (x, y)->
      0 <= y < @grid.length and
      0 <= x <= @grid[y].length

    distance: (a, b)->
      Math.abs(a[0] - b[0]) +
      Math.abs(a[1] - b[1])

    neighbors: (node)->
      NEIGHBORS
        .map (n)->
          [node[0] + n[0], node[1] + n[1]]
        .filter (n)=>
          @checkBounds(n[0], n[1]) and not @grid[n[1]][n[0]]

    makePath: (closed, node)->
      ret = [node]
      ret.push node while node = closed[node]
      ret
