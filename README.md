Zeddy's A-Star Implementation
=============================

I made this for personal use. If you wanna use it too then that's cool, whatever.

Basic Usage
===========

```coffeescript
AStar = require 'a-star'

finder = new Astar [
  'OOOOOOO',
  'O     O',
  'O OOO O',
  'O  O  O',
  'O OOO O',
  'O     O',
  'OOOOOOO'
].map (row)-> row.split('').map (tile)-> tile.trim()

finder.path [2, 3], [4, 3]
# [[2, 3],[1, 3],[1, 4],[1, 5], [2, 5], [3, 5], [4, 5], [5, 5], [5, 4], [5, 3], [4, 3]]

```
Options
=======

**max**
Max length of path.
_default: Infinity_
```coffeescript
finder.path [2, 3], [4, 3], max: 4
# [[2, 3],[1, 3],[1, 4],[1, 5]]

```
**deadzone:**
Distance within destination path can be considered done.
Measured in manhattan distance.
 _(default: 0)_
```coffeescript
finder.path [1, 3], [4, 3], deadzone: 2
# [[1, 3],[2, 3]]

```
