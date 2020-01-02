
;; Free the right option key from META. Need it to type some charactes
;; (setq ns-left-alternate-modifier 'none)


(setq
 doom-font (font-spec :family "Fira Code" :size 14)
 doom-variable-pitch-font (font-spec :family "Avenir Next" :size 15)
 global-auto-revert-mode t
 ;; shell-file-name "/bin/sh"
 )


;; Bindings
(map!
 "C-c l" #'org-store-link
 "C-c /" #'org-sparse-tree
 )

;; mu4e
(define-key evil-normal-state-map (kbd "SPC a") #'mu4e)

;; hl-todo
;; (define-key hl-todo-mode-map (kbd "C-c p") #'hl-todo-previous)
;; (define-key hl-todo-mode-map (kbd "C-c n") #'hl-todo-next)
;; (define-key hl-todo-mode-map (kbd "C-c o") #'hl-todo-occur)
;; (define-key hl-todo-mode-map (kbd "C-c i") #'hl-todo-insert)

;; Setup my agenda files
(define-key global-map "\C-ca" 'org-agenda)

;; Refiles to these files
(define-key global-map "\C-cr" 'org-refile)


;; Capture
(define-key global-map "\C-cc" 'org-capture)

(setq

 ;; Modes
 web-mode-markup-indent-offset 4
 web-mode-code-indent-offset 4
 web-mode-css-indent-offset 4

 mac-right-option-modifier 'right ; Set right only

 dired-dwim-target t
 )

;; Org
(setq
 org-agenda-skip-scheduled-if-done t
 org-reverse-note-order t
 org-todo-keyword-faces '(("NEXT" . "Yellow")
                          ("TODO" . "Palegreen4")
                          ("WAITING" . "DarkOliveGreen")
                          ("DONE" . "YellowGreen")
                          ("CANCELLED" .  "Palevioletred4"))

 ;; Org tags
 org-tag-alist '(( "@HOME" . ?H) ( "@WORK" . ?W) ( "@INPRESS" . ?I) ( "@OUT" . ?O) ( "@ANYTIME" . ?A) ( "@DAYTIME" . ?D) ( "leaving" . ?l) ( "focus" . ?f) ( "routine" . ?r) ( "do" . ?d) ( "5min" . ?5) )

 ;; Effort and global properties
 org-global-properties '(("Effort_ALL". "0 0:05 0:10 0:15 0:20 0:25"))

 ;; Set global Column View format
 org-columns-default-format '"%38ITEM(Details) %TAGS(Context) %7TODO(To Do) %5Effort(Time){:} %6CLOCKSUM(Clock)"

 org-bullets-bullet-list '("⁖")
 org-ellipsis " ... "
 )

(after! org
  (setq org-capture-templates '(("t" "Todo [inbox]" entry
                                 (file+headline "~/Dropbox/org/inbox.org" "Tasks")
                                 "* TODO %i%?")
                                ;; Tickler item
                                ("T" "Tickler" entry
                                 (file+headline "~/Dropbox/Org/tickler.org" "Tickler")
                                 "* %i%? \n %U")
                                ;; Journal entry
                                ("j" "Journal" entry
                                 (file+datetree "~/Dropbox/Org/journal.org") "** %^{Heading}")
                                )
        org-tags-column -80
        org-archive-location "~/Dropbox/Org/Archive/archive.org::* From %s"
        org-default-notes-file "~/Dropbox/Org/Notes/notes.org"
        +org-capture-todo-file "inbox.org"
        ;; Org keywords
        org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "SCHEDULED(s)" "WAITING(w)" "|" "DONE(d)" ))
        org-directory "~/Dropbox/Org/"
        org-agenda-files '("~/Dropbox/Org/inbox.org"
                           "~/Dropbox/Org/work.org"
                           "~/Dropbox/Org/personal.org"
                           "~/Dropbox/Org/tickler.org")
        org-refile-targets '(("~/Dropbox/Org/work.org" :maxlevel . 2)
                             ("~/Dropbox/Org/personal.org" :maxlevel . 1)
                             ("~/Dropbox/Org/someday.org" :maxlevel . 1)
                             ("~/Dropbox/Org/tickler.org" :maxlevel . 1))
        )
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




(setq-hook! 'eshell-mode-hook company-idle-delay nil)



;; Mail - mu4e
(require 'mu4e)

(setq mu4e-change-filenames-when-moving t)
;;location of my maildir
(setq mu4e-maildir (expand-file-name "~/mbsync"))

(setq mu4e-enable-notifications t)
(setq mu4e-attachment-dir  "~/Downloads")
(setq mu4e-enable-mode-line t)

(setq mail-user-agent 'mu4e-user-agent)
(setq mu4e-drafts-folder "/[Gmail].Drafts")
(setq mu4e-sent-folder   "/[Gmail].Sent Mail")
(setq mu4e-trash-folder  "/[Gmail].Trash")
(setq mu4e-refile-folder "/[Gmail].All Mail")
(setq mu4e-sent-messages-behavior 'delete)
(setq mu4e-headers-skip-duplicates t)
(setq mu4e-use-fancy-chars t)
(setq mu4e-alert-interesting-mail-query "flag:unread AND maildir:~/INBOX")
(setq mu4e-display-update-status-in-modeline t)
(setq mu4e-hide-index-messages t)
(setq mu4e-headers-include-related nil)
(setq mu4e-update-interval 300)
(setq mu4e-html2text-command "w3m -dump -T text/html -o display_link_number=true")
(setq mu4e-maildir-shortcuts
      '( ("/INBOX"               . ?i)
         ("/[Gmail].Sent Mail"   . ?s)
         ("/[Gmail].Trash"       . ?t)
         ("/[Gmail].All Mail"    . ?a)))
;; (setq mu4e-get-mail-command "offlineimap")
(setq mu4e-get-mail-command "mbsync -c ~/.mbsyncrc gmail")
(setq user-mail-address "johan@johanabelson.com")
(setq mu4e-user-mail-address-list '("johan@johanabelson.com"))
(setq mu4e-compose-dont-reply-to-self t)
(setq mu4e-compose-format-flowed t)
(setq mu4e-compose-complete-only-personal t)
(setq user-full-name "Johan Abelson")
(setq mu4e-compose-mode-hook
      (lambda ()
        (use-hard-newlines -1)
        (turn-off-auto-fill)
        (visual-line-mode)))
(require 'smtpmail)
(setq message-send-mail-function 'smtpmail-send-it
      starttls-use-gnutls t
      smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
      smtpmail-auth-credentials '(("smtp.gmail.com" 587 "johan@johanabelson.com" "xitneV-gybcy9-tycxiz"))
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587)
(setq message-kill-buffer-on-exit t)
;;set up queue for offline email
;;use mu mkdir  ~/mbsync/queue to set up first
(setq smtpmail-queue-mail nil  ;; start in normal mode
      smtpmail-queue-dir   "~/mbsync/queue/cur")

(after! org
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
                      :foreground "steelblue2"
                      :background nil
                      :height 1.2
                      :weight 'normal)
  (set-face-attribute 'org-level-2 nil
                      :foreground "slategray2"
                      :background nil
                      :height 1.0
                      :weight 'normal)
  (set-face-attribute 'org-level-3 nil
                      :foreground "SkyBlue2"
                      :background nil
                      :height 1.0
                      :weight 'normal)
  (set-face-attribute 'org-level-4 nil
                      :foreground "DodgerBlue2"
                      :background nil
                      :height 1.0
                      :weight 'normal)
  (set-face-attribute 'org-level-5 nil
                      :weight 'normal)
  (set-face-attribute 'org-level-6 nil
                      :weight 'normal)
  (set-face-attribute 'org-document-title nil
                      :foreground "SlateGray1"
                      :background nil
                      :height 1.75
                      :weight 'bold)
  ;; (setq org-fancy-priorities-list '("⚡" "⬆" "⬇" "☕"))

  (setq org-agenda-custom-commands
        '(("c" . "My Custom Agendas")
          ("cu" "Unscheduled TODO"
           ((todo ""
                  ((org-agenda-overriding-header "\nUnscheduled TODO")
                   (org-agenda-skip-function '(org-agenda-skip-entry-if 'timestamp)))))
           nil
           nil)))
  )

;; Language
(add-hook!
 js2-mode 'prettier-js-mode
 (add-hook 'before-save-hook #'refmt-before-save nil t))

;; Org Projectile
;; (use-package org-projectile
;;   :bind (("C-c n p" . org-projectile-project-todo-completing-read)
;;          ("C-c c" . org-capture))
;;   :config
;;   (progn
;;     (setq org-projectile-projects-file "~/Dropbox/Org/projects.org")
;;     (setq org-agenda-files (append org-agenda-files (org-projectile-todo-files)))
;;     (push (org-projectile-project-todo-entry) org-capture-templates))
;;   :ensure t)

(require 'org-projectile)
(setq org-projectile-projects-file "~/Dropbox/Org/projects.org")
(push (org-projectile-project-todo-entry) org-capture-templates)
(setq org-agenda-files (append org-agenda-files (org-projectile-todo-files)))
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c n p") 'org-projectile-project-todo-completing-read)

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
