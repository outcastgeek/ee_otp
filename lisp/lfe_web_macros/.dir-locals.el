;; https://projectile.readthedocs.io/en/latest/configuration/
;; Projectile Configuration
((nil . ((eval . (setq projectile-project-root
                       (locate-dominating-file buffer-file-name
                                               ".dir-locals.el")))
         (eval . (setq compile-command
                       `(format "cd %s && make"
                                (locate-dominating-file buffer-file-name
                                                        ".dir-locals.el"))))
         (eval . (setq inferior-lfe-program "deps/lfe/bin/lfe"))

         (eval . (setq inferior-lfe-program-options '("-pa" "deps/*/ebin" "ebin")))
         )))

