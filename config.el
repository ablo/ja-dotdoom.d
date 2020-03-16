(load-theme 'doom-spacegrey)
(add-hook! 'org-mode-hook)

(setq doom-font (font-spec :family "Fira Code" :size 14))
(setq doom-variable-pitch-font (font-spec :family "Avenir Next" :size 15))
;; (setq +doom-dashboard-banner-file (expand-file-name "doom-star .png" doom-private-dir))
(setq global-auto-revert-mode t)

(setq explicit-shell-file-name "/bin/bash")
(setq tramp-connection-timeout 10)

;; Enable tabs
(setq custom-tab-width 4)
;; (defun disable-tabs () (setq indent-tabs-mode nil))
(defun enable-tabs  ()
  (local-set-key (kbd "TAB") 'tab-to-tab-stop)
  (setq tab-width custom-tab-width)
  (setq indent-tabs-mode t)
  (setq web-mode-indent-style 2)
  (setq web-mode-script-padding 4)
  )

(add-hook 'web-mode-hook 'enable-tabs)
(add-hook 'php-mode-hook 'enable-tabs)
(add-hook 'php-mode-maybe-hook 'enable-tabs)
(add-hook 'js2-indent-hook 'enable-tabs)
(add-hook 'tsv-mode-hook 'enable-tabs)
;; -

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
;; (define-key global-map (kbd "C-M-<down>") 'scroll-down-line)
;; (define-key global-map (kbd "C-M-<up>") 'scroll-up-line)
(define-key global-map (kbd "<home>") 'mu4e)


;; (map :prefix "d D"
;;      :keymaps 'smartparens-mode-map
;;      "S" '(sp-splice-sexp-killing-around :wk "Splice"))

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
 org-agenda-skip-scheduled-if-deadline-is-shown nil
 ;; org-agenda-start-day "-2d"
 org-agenda-start-day nil
 org-agenda-start-on-weekday nil
 org-agenda-span 'week
 org-deadline-warning-days 3
 org-habit-show-habits t
 org-habit-show-habits-only-for-today nil

 ;; Agenda size
 org-agenda-window-setup 'reorganize-frame
 org-agenda-window-frame-fractions '(0.75 . 1.25)
 org-agenda-restore-windows-after-quit t

 org-reverse-note-order t
 org-todo-keyword-faces '(("TODO" . "YellowGreen")
                          ("PROJ" . "GreenYellow")
                          ("WAIT" . "Yellow")
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
                                 (file+headline "~/Dropbox/Org/gtd/gtd.org" "INBOX")
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
        +org-capture-todo-file "~/Dropbox/Org/gtd/gtd.org"
        +org-capture-notes-file "~/Dropbox/Org/notes/notes.org"
        +org-capture-journal-file "~/Dropbox/Org/journal/journal.org"
        +org-capture-projects-file "~/Projects/projects.org"
        
        org-agenda-files '("~/Dropbox/Org/gtd/gtd.org"
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
        org-todo-keywords '((sequence "TODO(t)" "PROJ(+)" "WAIT(w)" "|" "DONE(d)"))
        )

  (defun air-org-skip-subtree-if-priority (priority)
    "Skip an agenda subtree if it has a priority of PRIORITY.

PRIORITY may be one of the characters ?A, ?B, or ?C."
    (let ((subtree-end (save-excursion (org-end-of-subtree t)))
          (pri-value (* 1000 (- org-priority-lowest priority)))
          (pri-current (org-get-priority (thing-at-point 'line t))))
      (if (= pri-value pri-current)
          subtree-end
        nil)))

(defun air-org-skip-subtree-if-habit ()
  "Skip an agenda entry if it has a STYLE property equal to \"habit\"."
  (let ((subtree-end (save-excursion (org-end-of-subtree t))))
    (if (string= (org-entry-get nil "STYLE") "habit")
        subtree-end
      nil)))

  ;; (key desc type match settings files)
  ;; (setq org-agenda-custom-commands
  ;;       '(
  ;;         ("c" "Simple agenda view"
  ;;          ((tags "PRIORITY=\"A\""
  ;;                 ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
  ;;                  (org-agenda-overriding-header "High-priority unfinished tasks:")))
  ;;           (agenda "")
  ;;           (alltodo ""
  ;;                    ((org-agenda-skip-function
  ;;                      '(or (air-org-skip-subtree-if-priority ?A)
  ;;                           (org-agenda-skip-if nil '(scheduled deadline))))))))
  ;;         ("t" "TODAY"
  ;;          ((agenda)
  ;;           (tags-todo "@work"))
  ;;          ((org-agenda-overriding-header "Today's Tasks")
  ;;           (org-agenda-files '("~/Dropbox/Org/gtd/"))
  ;;           (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo '("WAITING")))
  ;;           (org-agenda-span 1))
  ;;          )
  ;;         ("w" "Work-mode" ((agenda) (tags-todo "+PRIORITY=\"A\"+@work"))
  ;;          ((org-agenda-files '("~/Dropbox/Org/gtd/gtd.org" "~/Dropbox/Org/notes/" "~/Dropbox/Org/gtd/projects.org"))
  ;;           (org-agenda-skip-function '(org-agenda-skip-entry-if 'scheduled 'todo '("WAITING")))
  ;;           (org-agenda-sorting-strategy '(priority-down effort-down)))
  ;;          )
  ;;         ("W" "Planning Work" tags-todo "@work"
  ;;          ((org-agenda-files '("~/Dropbox/Org/gtd/gtd.org" "~/Dropbox/Org/notes/" "~/Dropbox/Org/gtd/projects.org"))
  ;;           (org-agenda-skip-function '(org-agenda-skip-entry-if 'scheduled))
  ;;           (org-agenda-sorting-strategy '(priority-down effort-down)))
  ;;          )
  ;;         ("i" "InPress-mode" tags-todo "+CATEGORY=\"InPress\"|@inpress"
  ;;          ((org-agenda-files '("~/Dropbox/Org/gtd/gtd.org" "~/Dropbox/Org/notes/"))
  ;;           (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo '("WAITING" "REVIEW" "IDEA" "JÖRGEN")))
  ;;           (org-agenda-sorting-strategy '(priority-down effort-down)))
  ;;          )
  ;;         ("h" "Home-mode" tags-todo "@home"
  ;;          ((org-agenda-files '("~/Dropbox/Org/gtd/gtd.org"))
  ;;           (org-agenda-skip-function '(org-agenda-skip-entry-if 'scheduled 'todo '("WAITING")))
  ;;           (org-agenda-sorting-strategy '(priority-down effort-down)))
  ;;          )
  ;;         ("5" "5 mins" tags-todo "+5min-@inpress"
  ;;          ((org-agenda-files '("~/Dropbox/Org/gtd/gtd.org"))
  ;;           (org-agenda-skip-function '(org-agenda-skip-entry-if 'scheduled 'todo '("WAITING")))
  ;;           (org-agenda-sorting-strategy '(priority-down effort-down)))
  ;;          )
  ;;         ("l" tags "+@leaving")
  ;;         ("k" tags "+@kate")
  ;;         ))

  (setq org-agenda-custom-commands
        '(("d" "Daily agenda and all TODOs"
           ((tags "PRIORITY=\"A\""
                  ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                   (org-agenda-overriding-header "TODAY:")))
            (agenda)
            (alltodo ""
                     ((org-agenda-skip-function '(or (air-org-skip-subtree-if-habit)
                                                     (air-org-skip-subtree-if-priority ?A)
                                                     (org-agenda-skip-if nil '(scheduled deadline))))
                      (org-agenda-overriding-header "NEXT:")))
            (tags-todo "+CATEGORY=\"InPress\"|@inpress"
                       ((org-agenda-files '("~/Dropbox/Org/gtd/gtd.org" "~/Dropbox/Org/notes/"))
                        (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo '("WAIT" "REVIEW" "IDEA" "JÖRGEN")))
                        (org-agenda-sorting-strategy '(priority-down effort-down))
                        (org-agenda-overriding-header "@InPress:")))
            )
           ;; ((org-agenda-compact-blocks t))
           )))

  (setq org-agenda-include-diary nil)

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

;; Mail - mu4e
(require 'mu4e)
;;location of my maildir
(setq mu4e-maildir (expand-file-name "~/mbsync"))

(setq mu4e-enable-notifications t)
(setq mu4e-attachment-dir  "~/Downloads")
(setq mu4e-enable-mode-line t)

(setq mu4e-change-filenames-when-moving t)
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
