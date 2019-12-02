
;; Free the right option key from META. Need it to type some charactes
;; (setq ns-left-alternate-modifier 'none)
(setq mac-right-option-modifier 'none)

(setq user-full-name "Johan Abelson"
      user-mail-address "johan@johanabelson.com"
      epa-file-encrypt-to user-mail-address

      ;; Line numbers are pretty slow all around. The performance boost of
      ;; disabling them outweighs the utility of always keeping them on.
      display-line-numbers-type nil

      ;; On-demand code completion. I don't often need it.
      company-idle-delay nil

      ;; lsp-ui-sideline is redundant with eldoc and much more invasive, so
      ;; disable it by default.
      lsp-ui-sideline-enable nil
      lsp-enable-indentation nil
      lsp-enable-on-type-formatting nil
      lsp-enable-symbol-highlighting nil
      lsp-enable-file-watchers nil

      )

;; UI
(setq doom-font (font-spec :family "Fira Code" :size 12)
      doom-variable-pitch-font (font-spec :family "Noto Sans" :size 13))

(custom-theme-set-faces! 'doom-one
  `(org-priority :background ,(doom-color 'bg))
  `(mode-line :foreground ,(doom-color 'blue))
  `(mode-line-buffer-id :foreground ,(doom-color 'fg))
  `(mode-line-success-highlight :background ,(doom-color 'green)))

;; KEYS

;; MAGIT
(setq magit-repository-directories '(("~/Projects" . 2))
      )

;; ORG
(require 'org)
    ;; Org folder
    (setq org-directory "~/Dropbox/Org/")
    (setq org-archive-location "~/Dropbox/Org/Archive/archive.org::* From %s")
    (setq org-default-notes-file "/Users/johanabelson/org/notes.org")

    ;; Setup my agenda files
    (define-key global-map "\C-ca" 'org-agenda)
    (setq org-agenda-files '(
                             "~/Dropbox/Org/gtd.org"
                             "~/Dropbox/Org/tickler.org"
                             ))
    ;; Refiles to these files
    (define-key global-map "\C-cr" 'org-refile)

    (setq org-refile-targets '(("~/Dropbox/Org/gtd.org" :maxlevel . 2)
                               ("~/Dropbox/Org/someday.org" :maxlevel . 1)
                               ("~/Dropbox/Org/tickler.org" :maxlevel . 1)
                               ("~/Dropbox/Org/Notes/notes.org" :maxlevel . 1)
                               ("~/Dropbox/Org/Notes/InPress/inpress-notes.org" :maxlevel . 1)))

    ;; Capture
    (define-key global-map "\C-cc" 'org-capture)
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

                                  ;; Note
                                  ("n" "Notes" entry (file+datetree "~/Dropbox/Org/Notes/notes.org")
                                   "* %^{Description} %^g
%?
Added: %U")

                                  ;; Blog post project
                                  ("B" "New blog post project" entry (file+headline
                                                                      "~/dropbox/org/gtd.org" "Writing for blog")
                                   "* Blog: %^{Description} [0/7] %^g
** TODO (10min): Outline headlines
** TODO (25min): Research about subject and put links in pinboard
** TODO (25min): Write for 25min oe the next \"empty\" headliee in the list, and repeat this step until done
** TODO (25min): Collect images for post
** TODO (15min): Add affiliate links to post
** TODO (10min): Publish post
** TODO (25min): Spread the word about my new post on social media
")))

    ;; Org keywords
    (setq org-todo-keywords '((sequence "NEXT(n)" "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))

    ;; Org tags
    (setq org-tag-alist '(( "@HOME" . ?H) ( "@WORK" . ?W) ( "@INPRESS" . ?I) ( "@OUT" . ?O) ( "anytime" . ?a) ( "daytime" . ?d) ( "leaving" . ?l) ( "focus" . ?f) ( "do" . ?d) ( "5min" . ?5) ))

    ;; Effort and global properties
    (setq org-global-properties '(("Effort_ALL". "0 0:05 0:10 0:15 0:20 0:25")))

    ;; Set global Column View format
    (setq org-columns-default-format '"%38ITEM(Details) %TAGS(Context) %7TODO(To Do) %5Effort(Time){:} %6CLOCKSUM(Clock)")

    ;; Org faces
    (setq org-todo-keyword-faces
          '(("NEXT" . "Yellow")
            ("TODO" . "Palegreen4")
            ("WAITING" . "DarkOliveGreen")
            ("DONE" . "YellowGreen")
            ("CANCELLED" .  "Palevioletred4")))

    ;; (setq org-agenda-start-on-weekday 1)
    (setq calendar-week-start-day 1)
    (setq org-agenda-window-setup 'current-window)

 ;; Mail - mu4e
  (require 'mu4e)
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
