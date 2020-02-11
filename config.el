
(add-hook! 'org-mode-hook)

(setq doom-font (font-spec :family "Fira Code" :size 14))
(setq doom-variable-pitch-font (font-spec :family "Avenir Next" :size 15))
;; (setq +doom-dashboard-banner-file (expand-file-name "doom-star .png" doom-private-dir))
(setq global-auto-revert-mode t)

(setq explicit-shell-file-name "/bin/bash")
(setq tramp-connection-timeout 10)

;; Enable tabs
(setq custom-tab-width 4)
(defun disable-tabs () (setq indent-tabs-mode nil))
(defun enable-tabs  ()
  (local-set-key (kbd "TAB") 'tab-to-tab-stop)
  ;; (setq indent-tabs-mode t)
  (setq tab-width custom-tab-width)
  (setq web-mode-indent-style 1)
  (setq web-mode-script-padding nil)
  )

(add-hook 'web-mode-hook 'enable-tabs)
(add-hook 'php-mode-hook 'enable-tabs)
(add-hook 'js2-mode-hook 'enable-tabs)

;; -

  (setq indent-tabs-mode t)
;; Web mode
(setq web-mode-enable-current-element-highlight t
      web-mode-enable-current-column-highlight nil)


;; (use-package! org-alert
;;   :config
;;   (setq alert-default-style 'libnotify))

;; Blogging with Emacs
(setq org2blog/wp-blog-alist
      '(("Eat That Frog"
         :url "https://eat-that-frog.com/xmlrpc.php"
         :username "ablo")
        ("Photography Gadgets"
         :url "https://photography-gadgets.com/xmlrpc.php"
         :username "ablo"))
      org2blog/wp-show-post-in-browser t)

;; Bindings
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cr" 'org-refile)
(define-key global-map "\C-cc" 'org-capture)

;; Need to use right modifier for some characters
(setq mac-right-option-modifier 'right)


;; Deft
(setq deft-directory "~/Dropbox/Org/notes")
(setq deft-recursive t)

(setq
 org-agenda-skip-scheduled-if-done t
 org-agenda-skip-deadline-if-done t
 org-agenda-todo-ignore-with-date t
 org-agenda-skip-deadline-prewarning-if-scheduled nil
 org-agenda-skip-scheduled-if-deadline-is-shown t
 
 ;; Agenda size
 org-agenda-window-setup 'reorganize-frame
 org-agenda-window-frame-fractions '(0.75 . 1.25)
 org-agenda-restore-windows-after-quit t

 org-reverse-note-order t
 org-todo-keyword-faces '(("TODO" . "YellowGreen")
                          ("WAITING" . "Yellow")
                          ("DONE" . "DimGray")
                          ("CANCELLED" . "DarkRed"))

 ;; Set global Column View format
 ;; org-columns-default-format '"%38ITEM(Details) %TAGS(Context) %7TODO(To Do) %5Effort(Time){:} %6CLOCKSUM(Clock)"

 org-bullets-bullet-list '("⁖")
 org-ellipsis " ... "
 org-id-locations-file "~/Dropbox/Org/.orgids"
 )

(after! org
  (setq org-capture-templates '(("t" "Todo [inbox]" entry
                                 (file+headline "~/Dropbox/Org/gtd/inbox.org" "Tasks")
                                 "* TODO %i%?")
                                ;; Tickler item
                                ("T" "Tickler" entry
                                 (file+headline "~/Dropbox/Org/gtd/tickler.org" "Tickler")
                                 "* %i%? \n %U")
                                ;; Journal entry
                                ("j" "Journal" entry
                                 (file+olp+datetree "~/Dropbox/Org/notes/journal.org") "** %^{Heading}")
                                )
        org-tags-column -80
        org-directory "~/Dropbox/Org/"
        +org-export-directory org-directory
        org-archive-location "~/Dropbox/Org/Archive/archive.org::* From %s"
        org-default-notes-file "~/Dropbox/Org/notes/notes.org"
        +org-capture-todo-file "~/Dropbox/Org/gtd/inbox.org"
        +org-capture-notes-file "~/Dropbox/Org/notes/notes.org"
        +org-capture-journal-file "~/Dropbox/Org/journal/journal.org"
        +org-capture-projects-file "~/Projects/projects.org"
        
        org-agenda-files '("~/Dropbox/Org/gtd/inbox.org"
                           "~/Dropbox/Org/gtd/gtd.org"
                           "~/Dropbox/Org/gtd/tickler.org")

        org-refile-targets '(("~/Dropbox/Org/gtd/gtd.org" :maxlevel . 2)
                             ("~/Dropbox/Org/gtd/someday.org" :maxlevel . 1)
                             ("~/Dropbox/Org/gtd/tickler.org" :maxlevel . 1))
                
        ;; ;; Set Org tags

        org-tag-alist '(("@computer" . ?c) ("@offline" . ?o)
                        (:newline . nil)
                        ("@anytime" . ?t) ("@daytime" . ?d) ("@leaving" . ?l)
                        (:newline . nil)
                        ("@anywhere" . ?a) ("@work" . ?w) ("@inpress" . ?i) ("@home" . ?h) ("@school" . ?s) ("@errand" . ?e)
                        (:newline . nil)
                        ("@kate" . ?k)
                        (:newline . nil)
                        ("5min" . ?5)
                        )

        ;; Keywords
        org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)"))
        )

  ;; (key desc type match settings files)
  (setq org-agenda-custom-commands
        '(("w" "Work-mode" tags-todo "+PRIORITY=\"A\"+@work"
           ((org-agenda-files '("~/Dropbox/Org/gtd/gtd.org" "~/Dropbox/Org/notes/" "~/Dropbox/Org/gtd/projects.org"))
            (org-agenda-skip-function '(org-agenda-skip-entry-if 'scheduled 'todo '("WAITING")))
            (org-agenda-sorting-strategy '(priority-down effort-down)))
           )
          ("W" "Planning Work" tags-todo "@work"
           ((org-agenda-files '("~/Dropbox/Org/gtd/gtd.org" "~/Dropbox/Org/notes/" "~/Dropbox/Org/gtd/projects.org"))
            (org-agenda-skip-function '(org-agenda-skip-entry-if 'scheduled))
            (org-agenda-sorting-strategy '(priority-down effort-down)))
           )
          ("i" "InPress-mode" tags-todo "+CATEGORY=\"InPress\"|@inpress"
           ((org-agenda-files '("~/Dropbox/Org/gtd/gtd.org" "~/Dropbox/Org/notes/"))
            (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo '("WAITING" "REVIEW" "IDEA" "JÖRGEN")))
            (org-agenda-sorting-strategy '(priority-down effort-down)))
           )
          ("h" "Home-mode" tags-todo "@home"
           ((org-agenda-files '("~/Dropbox/Org/gtd/gtd.org"))
            (org-agenda-skip-function '(org-agenda-skip-entry-if 'scheduled 'todo '("WAITING")))
            (org-agenda-sorting-strategy '(priority-down effort-down)))
           )
          ("5" "5 mins" tags-todo "+5min-@inpress"
           ((org-agenda-files '("~/Dropbox/Org/gtd/gtd.org"))
            (org-agenda-skip-function '(org-agenda-skip-entry-if 'scheduled 'todo '("WAITING")))
            (org-agenda-sorting-strategy '(priority-down effort-down)))
           )
          ("l" tags "+@leaving")
          ("k" tags "+@kate")
))
        ;; (setq org-agenda-include-diary t)

  (set-face-attribute 'org-link nil
                      :weight 'normal
                      :background nil)
  (set-face-attribute 'org-code nil
                      :foreground "#a9a1e1"
                      :background nil)
  (set-face-attribute 'org-date nil
                      :foreground "#5B6268"
                      :background nil)
  (set-face-attribute 'org-level-1 nil
                      :foreground "steelblue1"
                      :background nil
                      :height 1.4
                      :weight 'normal)
  (set-face-attribute 'org-level-2 nil
                      ;; :foreground "slategray2"
                      :foreground "SkyBlue2"
                      :background nil
                      :height 1.1
                      :weight 'normal)
  (set-face-attribute 'org-level-3 nil
                      :foreground "slategray2"
                      :background nil
                      :height 1.1
                      :weight 'normal)
  (set-face-attribute 'org-level-4 nil
                      :foreground "SkyBlue3"
                      :background nil
                      :height 1.1
                      :weight 'normal)
  (set-face-attribute 'org-level-5 nil
                      :foreground "SkyBlue4"
                      :background nil
                      :height 1.1
                      :weight 'normal)
  (set-face-attribute 'org-level-6 nil
                      :foreground "DodgerBlue1"
                      :background nil
                      :height 1.1
                      :weight 'normal)
  (set-face-attribute 'org-document-title nil
                      :foreground "SlateGray1"
                      :background nil
                      :height 1.75
                      :weight 'bold)
  )

(setq
 calendar-week-start-day 1
 user-full-name "Johan Abelson"
 user-mail-address "johan@johanabelson.com"
 epa-file-encrypt-to user-mail-address

 ;; Line numbers are pretty slow all around. The performance boost of
 ;; disabling them outweighs the utility of always keeping them on.
 display-line-numbers-type nil

 ;; Magit
 magit-repository-directories '(("~/Projects" . 2))
 )

;; Language
(add-hook!
 js2-mode 'prettier-js-mode
 (add-hook 'before-save-hook #'refmt-before-save nil t))

;; web-beautify
(eval-after-load 'js2-mode
  '(define-key js2-mode-map (kbd "C-c b") 'web-beautify-js))
;; Or if you're using 'js-mode' (a.k.a 'javascript-mode')
(eval-after-load 'js
  '(define-key js-mode-map (kbd "C-c b") 'web-beautify-js))

(eval-after-load 'json-mode
  '(define-key json-mode-map (kbd "C-c b") 'web-beautify-js))

(eval-after-load 'sgml-mode
  '(define-key html-mode-map (kbd "C-c b") 'web-beautify-html))

(eval-after-load 'web-mode
  '(define-key web-mode-map (kbd "C-c b") 'web-beautify-html))

(eval-after-load 'css-mode
  '(define-key css-mode-map (kbd "C-c b") 'web-beautify-css))
