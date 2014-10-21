;;; elixir-utils.el ---

;;; Commentary:
;;

(defvar elixir-utils--elixir-project-root-indicator
  "mix.exs"
  "The file which indicate an elixir project root.")

(defun elixir-utils--elixir-project-root ()
  "Finds the root directory of the project.
It walking the directory tree until it finds a elixir project root indicator."
  (let* ((file (file-name-as-directory (expand-file-name default-directory))))
    (locate-dominating-file file elixir-utils--elixir-project-root-indicator)))

(defun elixir-utils-flatten (alist)
  (cond ((null alist) nil)
        ((atom alist) (list alist))
        (t (append (elixir-utils-flatten (car alist))
                   (elixir-utils-flatten (cdr alist))))))

(defun elixir-utils-build-runner-cmdlist (command)
  "Build the commands list for the runner."
  (remove "" (elixir-utils-flatten
              (list (if (stringp command)
                        (split-string command)
                      command)))))

(defun elixir-utils-establish-project-root-directory ()
  "Set the default-directory to the Elixir project root."
  (let ((project-root (elixir-utils--elixir-project-root)))
    (if (not project-root)
        (error "Couldn't find any elixir project root")
      (setq default-directory project-root))))

(provide 'elixir-utils)

;;; elixir-utils.el ends here
