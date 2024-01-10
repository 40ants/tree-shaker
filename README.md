Experimental SBCL treeshaker
============================

Run `./build.sh` to produce results like that:


```
15M Jan 10 15:58 not-shaked-fat
65M Jan 10 15:58 not-shaked-not-compressed-fat
41M Jan 10 15:58 not-shaked-not-compressed-slim
10M Jan 10 15:58 not-shaked-slim
12M Jan 10 15:58 shaked-fat
50M Jan 10 15:58 shaked-not-compressed-fat
35M Jan 10 15:58 shaked-not-compressed-slim
 9M Jan 10 15:58 shaked-slim
```

Where you see `shaked` in the name - a tree shaker was applied.

If there is `fat` in the name - these libraries were loaded
from the Quicklisp (but not used):

- serapeum
- alexandria
- dexador
- yason
- clack

Results
-------

Tree shaker is able to reduce size of the fat app from 65M to 50M in uncompressed state and from 15M to 12M when compression is `on`.


