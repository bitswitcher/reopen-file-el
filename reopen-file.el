;;; reopen-file.el --- reopen file
;; Time-stamp: <2012-04-12 18:00:00 bitswitcher>
;; Copyright (C) 2012 bitswitcher

;;; Code
(defun reopen-file ()
  (interactive)
  (let ((file-name (buffer-file-name))
        (old-supersession-threat
         (symbol-function 'ask-user-about-supersession-threat))
        (point (point)))
    (when file-name
      (fset 'ask-user-about-supersession-threat (lambda (fn)))
      (unwind-protect
          (progn
            (erase-buffer)
            (insert-file file-name)
            (set-visited-file-modtime)
            (goto-char point))
        (fset 'ask-user-about-supersession-threat
              old-supersession-threat)))))

(defun reopen-all-files ()
  (interactive)
  (dolist (buf (buffer-list))
    (with-current-buffer buf
      (reopen-file)
      )))

(provide 'reopen-file)
