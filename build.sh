#!/bin/bash

mkdir -p app
rm -fr app/*

# Just a simple hello world:

ros run -L sbcl-bin/2.2.2 --load hello.lisp \
    --eval "(save-lisp-tree-shake-and-die \"app/shaked-slim\" #'main)"
ros run -L sbcl-bin/2.2.2 --load hello.lisp \
    --eval "(save-lisp-tree-shake-and-die \"app/shaked-not-compressed-slim\" #'main :compress nil)"
ros run -L sbcl-bin/2.2.2 --load hello.lisp \
    --eval "(save-lisp-tree-shake-and-die \"app/not-shaked-slim\" #'main :shake nil)"
ros run -L sbcl-bin/2.2.2 --load hello.lisp \
    --eval "(save-lisp-tree-shake-and-die \"app/not-shaked-not-compressed-slim\" #'main :shake nil :compress nil)"

# With multiple libraries loaded:

ros run -L sbcl-bin/2.2.2 --load hello.lisp \
    --eval "(save-lisp-tree-shake-and-die \"app/shaked-fat\" #'main :fat t)"
ros run -L sbcl-bin/2.2.2 --load hello.lisp \
    --eval "(save-lisp-tree-shake-and-die \"app/shaked-not-compressed-fat\" #'main  :fat t :compress nil)"
ros run -L sbcl-bin/2.2.2 --load hello.lisp \
    --eval "(save-lisp-tree-shake-and-die \"app/not-shaked-fat\" #'main :fat t :shake nil)"
ros run -L sbcl-bin/2.2.2 --load hello.lisp \
    --eval "(save-lisp-tree-shake-and-die \"app/not-shaked-not-compressed-fat\" #'main :fat t :shake nil :compress nil)"
