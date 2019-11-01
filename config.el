
;; Free the right option key from META. Need it to type some charactes
(setq ns-right-alternate-modifier 'none)

(require 'org)
(setq org-directory "~/Dropbox/Org/")
;; Setup my agenda files
;; (define-key global-map "\C-cr" 'org-refile)
(setq org-agenda-files '("~/Dropbox/Org/inbox.org"
                         "~/Dropbox/Org/gtd.org"
                         "~/Dropbox/Org/tickler.org"))

(setq org-refile-targets '(("~/Dropbox/Org/gtd.org" :maxlevel . 3)
                           ("~/Dropbox/Org/someday.org" :level . 1)
                           ("~/Dropbox/Org/tickler.org" :maxlevel . 2)
                           ("~/Dropbox/Org/Notes/notes.org" :maxlevel . 2)))
;; Capture
(define-key global-map "\C-cc" 'org-capture)
(setq org-capture-templates '(("t" "Todo [inbox]" entry
                               (file+headline "~/Dropbox/Org/inbox.org" "Tasks")
                               "* TODO %i%?")
                              ("T" "Tickler" entry
                               (file+headline "~/Dropbox/Org/tickler.org" "Tickler")
                               "* %I%? \n %U")))

(setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")));;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
