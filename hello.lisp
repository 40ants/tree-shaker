(ql:quickload :serapeum)
(ql:quickload :alexandria)
(ql:quickload :dexador)
(ql:quickload :yason)
(ql:quickload :clack)


(in-package :cl-user)


(defun main ()
  (format t "Hello World!~%"))


(defun save-lisp-tree-shake-and-die (file toplevel-fn &key (shake t) (compress t))
  "A dumb tree shaker for SBCL written with lots of advice from nyef."
  ;; Taken from https://gist.github.com/burtonsamograd/f08f561264ff94391300
  (when shake
    (let (packages)
      (mapc (lambda (package)
              (let ((package-name (package-name package)))
                (setf (sb-impl::package-%use-list package) nil)
                (setf (sb-impl::package-%used-by-list package) nil)
                (setf (sb-impl::package-%shadowing-symbols package) nil)
                (setf (sb-impl::package-internal-symbols package)
                      (sb-impl::make-package-hashtable 0))
                (setf (sb-impl::package-external-symbols package)
                      (sb-impl::make-package-hashtable 0))
                (setf (sb-impl::package-tables package) #())
                (setf (sb-impl::package-%implementation-packages package) nil)
                (setf (sb-impl::package-%local-nicknames package) nil)
                (setf (sb-impl::package-%nicknames package) nil)
                (push package-name packages)
                (do-symbols (symbol package-name)
                  (unless (keywordp symbol)
                    (sb-impl::%set-symbol-package symbol nil)
                    (unintern symbol)))))
            (list-all-packages))

      (dolist (package-name packages)
        (unless (string= "KEYWORD" package-name)
          (setf (sb-int:info-gethash package-name
                                     sb-impl::*package-names*)
                nil)))

      (loop repeat 10
            do (sb-ext:gc :full t))))

  (save-lisp-and-die file :executable t :toplevel toplevel-fn :purify t :compression compress))


