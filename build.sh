#!/bin/bash

ros run -L sbcl-bin/2.2.2 --load hello.lisp --eval "(save-lisp-tree-shake-and-die \"shaked-fat\" #'main)"
ros run -L sbcl-bin/2.2.2 --load hello.lisp --eval "(save-lisp-tree-shake-and-die \"shaked-not-compressed-fat\" #'main :compress nil)"
ros run -L sbcl-bin/2.2.2 --load hello.lisp --eval "(save-lisp-tree-shake-and-die \"not-shaked-fat\" #'main :shake nil)"
ros run -L sbcl-bin/2.2.2 --load hello.lisp --eval "(save-lisp-tree-shake-and-die \"not-shaked-not-compressed-fat\" #'main :shake nil :compress nil)"
