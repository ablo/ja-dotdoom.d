
;; Free the right option key from META. Need it to type some charactes
;; (setq ns-left-alternate-modifier 'none)

;; If your configuration needs are simple, the use-package!, after!, add-hook! and setq-hook! emacros can help you reconfigure packages

(add-hook! 'org-mode-hook)

(setq doom-font (font-spec :family "Fira Code" :size 14))
(setq doom-variable-pitch-font (font-spec :family "Avenir Next" :size 15))
(setq global-auto-revert-mode t)


;; Bindings

;; hl-todo
;; (define-key hl-todo-mode-map (kbd "C-c i") #'hl-todo-insert)

(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cr" 'org-refile)
(define-key global-map "\C-cc" 'org-capture)

;; Need to use right modifier for some characters
(setq mac-right-option-modifier 'right)

;; Deft
(setq deft-directory "~/Dropbox/Org/Notes")
(setq deft-recursive t)


(setq
 org-agenda-skip-scheduled-if-done t
 org-agenda-skip-deadline-if-done t
 org-agenda-todo-ignore-with-date t
 org-reverse-note-order t
 org-todo-keyword-faces '(("NEXT" . "Yellow")
                          ("TODO" . "Palegreen4")
                          ("WAITING" . "DarkOliveGreen")
                          ("DONE" . "YellowGreen"))

 ;; Set global Column View format
 org-columns-default-format '"%38ITEM(Details) %TAGS(Context) %7TODO(To Do) %5Effort(Time){:} %6CLOCKSUM(Clock)"

 org-bullets-bullet-list '("⁖")
 org-ellipsis " ... "
 )

(after! org
  (setq org-capture-templates '(("t" "Todo [inbox]" entry
                                 (file+headline "~/Dropbox/Org/inbox.org" "Tasks")
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
        org-directory "~/Dropbox/Org/"
        
        org-agenda-files '("~/Dropbox/Org/inbox.org"
                           "~/Dropbox/Org/work.org"
                           "~/Dropbox/Org/personal.org"
                           "~/Dropbox/Org/tickler.org")

        org-refile-targets '(("~/Dropbox/Org/work.org" :maxlevel . 2)
                             ("~/Dropbox/Org/personal.org" :maxlevel . 2)
                             ("~/Dropbox/Org/someday.org" :maxlevel . 1)
                             ("~/Dropbox/Org/tickler.org" :maxlevel . 1))
        )
  


  (setq org-agenda-custom-commands
        '(("c" . "My Custom Agendas")
          ("cu" "Unscheduled TODO"
           ((todo ""
                  ((org-agenda-overriding-header "\nUnscheduled TODO")
                   (org-agenda-skip-function '(org-agenda-skip-entry-if 'timestamp)))))
           nil
           nil))
        org-agenda-include-diary t)
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
                      :foreground "slategray2"
                      :background nil
                      :height 1.2
                      :weight 'normal)
  (set-face-attribute 'org-level-3 nil
                      :foreground "SkyBlue2"
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
