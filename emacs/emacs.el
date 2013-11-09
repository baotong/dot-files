;; TODO:
;; 1. divid emacs.d to static and dynamic directories, such as dirary, tempoary files.
;; 2. add static emacs.d files to github repos.
;; 3. support OS specific configurations, including MAC OS X and Linux

;;;;  0. init
(setenv "PATH" "/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/texbin:/usr/X11/bin:/opt/local/bin:/opt/local/sbin:/opt/texlive/2011/bin/x86_64-linux/")
;;(setenv "INFOPATH" "/usr/local/share/info:/usr/share/info:/opt/local/share/info")
;;(add-to-list 'Info-directory-list "~/emacs/info")

(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'supper)
(setq mac-control-modifier 'control)

(set-frame-font "Consolas-12")
;(set-frame-font "Monaco-12")

;;(require 'ibus)
;; Turn on ibus-mode automatically after loading .emacs
;;(add-hook 'after-init-hook 'ibus-mode-on)
;; Use C-SPC for Set Mark command
;(ibus-define-common-key ?\C-\s nil)

;; Use C-/ for Undo command
;;(ibus-define-common-key ?\C-/ nil)

;; Change cursor color depending on IBus status
;;(setq ibus-cursor-color '("red" "magenta" "limegreen"))

;; Use s-SPC to toggle input status

;;(global-set-key (kbd "s-SPC") 'ibus-toggle)

;; (set-fontset-font (frame-parameter nil 'font)  
;;                   'unicode '("STHeiti" . "unicode-bmp"))

(defvar has-spell-utility (cond ((eq system-type 'gnu/linux) t)
				(t nil)))


(setq ns-antialias-text t)
(defun mac-toggle-max-window ()
  (interactive)
  (set-frame-parameter nil 'fullscreen (if (frame-parameter nil 'fullscreen)
                                           nil
                                         'fullboth)))

(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
    (let* ((my-lisp-dir (expand-file-name "~/.emacs.d"))
           (glob-lisp-dir (expand-file-name "/usr/share/emacs/site-lisp/"))
           (default-directory my-lisp-dir))
      (setq load-path (cons my-lisp-dir load-path))
      (setq load-path (cons glob-lisp-dir load-path))
      (normal-top-level-add-subdirs-to-load-path)))

(defun switch-global-coding-system (coding-system)
  (interactive "zCoding system: ")
  (prefer-coding-system coding-system)
  (set-terminal-coding-system coding-system)
  (set-keyboard-coding-system coding-system))

(dolist (coding-system '(gbk utf-8))
  (prefer-coding-system coding-system))

(cond ((eq system-type 'windows-nt)
       (switch-global-coding-system 'gbk))
      (t
       (switch-global-coding-system 'utf-8)))


(setq debug-on-error t)
;; shortcut to open init-file using  register
;;(set-register ?e '(file . "~/.emacs.el"))
;; 导入配置的文件
(load-file "~/.emacs.d/my-custom.el")
                                        ;(load "my-custom.el")

(setq set-mark-command-repeat-pop t)
;; set session, record global variables, local variables, and recent opend files, etc
(require 'session)
(add-hook 'after-init-hook 'session-initialize)

;;(add-to-list 'load-path "~/.emacs.d")

(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory "~/.emacs.d/yasnippet-0.5.10/snippets")

;; browse kill ring

;;(require 'browse-kill-ring)
;;(global-set-key [(control c)(k)] 'browse-kill-ring)
;;(browse-kill-ring-default-keybindings)
;; set dired-x

(add-hook 'dired-load-hook
          (lambda ()
            (load "dired-x")
            ;; Set dired-x global variables here.  For example:
                                        ; (setq dired-guess-shell-gnutar "gtar")
                                        ; (setq dired-x-hands-off-my-keys nil)
            ))
;;(add-hook 'dired-mode-hook
;;          (lambda ()
;;            ;; Set dired-x buffer-local variables here.  For example:
;;            ;; (dired-omit-mode 1)
;;            ))
;;
(setq gc-cons-threshold 50000000)
;;;Don't echo passwords when communicating with interactive programs-
(add-hook 'comint-output-filter-functions
          'comint-watch-for-password-prompt)
;;;Disable over-write mode! Never good! Pain in the posterior!
(put 'overwrite-mode 'disabled t)

(setq default-tab-width 4)
(ansi-color-for-comint-mode-on)

;;(set-cursor-color "red")


(set-face-foreground 'font-lock-comment-face "#95917E")
(set-face-foreground 'font-lock-string-face "#61ce3c")
(set-face-foreground 'font-lock-keyword-face "#f8dd2d")
(set-face-foreground 'font-lock-function-name-face "#e3611f")
(set-face-foreground 'font-lock-variable-name-face "#98fbff")
(set-face-foreground 'font-lock-type-face "#A6E22E")


(set-face-foreground 'region "#272822")
(set-face-background 'region "#66D9EF")
(set-face-foreground 'font-lock-constant-face "#66d9ef")

(setq-default cursor-type 'box)

(setq default-frame-alist
      '((background-color . "#233b5a")
        (foreground-color . "#f8f8f2")
        (cursor-color . "red")
        (cursor-type . box)))

(setq kept-old-versions 2)
(setq kept-new-versions 5)
(setq delete-old-versions t)
(setq backup-directory-alist '(("." . "~/var/tmp")))
(setq backup-by-copying t)
;; (setq default-make-backup-files nil) ; no backup

;; set the default mode to be text mode and auto fill
(setq default-major-mode 'text-mode)
(add-hook 'text-mode-hook 'turn-on-auto-fill)
;;Set text-mode to automatically use long-lines mode.
(add-hook 'text-mode-hook 'longlines-mode)
(setq default-fill-column 130)
(setq x-select-enable-clipboard t) ; support to exchange data with outter.
(setq frame-title-format "Robert@%b")
;; fill commands to insert two spaces after a colon
(setq colon-double-space t)
;; prevent Extraneous Tabs, all indentation can be made from spaces only.
;; by using spaces only, you can make sure that
;; your file looks the same regardless of the tab width setting.
(setq-default indent-tabs-mode nil)

;; set default grep command, with -i -n -H -e switches
(setq grep-command "grep -i -nH -e ")

;; find an existing buffer, even if it has a different name
(setq find-file-existing-other-name t)

;; case sensitive when searching
(setq case-fold-search nil)

(setq mouse-yank-at-point t)

(setq kill-ring-max 200)
(setq line-number-display-limit 1000000)
;; 当行数超过一定数值，不再显示行号。
(setq bookmark-save-flag 1)
;; 每当设置书签的时候都保存书签文件，否则只在你退出 Emacs 时保存。
;;Set the directory abbreviations are to be set in, and have abbrevs
;;auto-save itself and not ask questions.
(setq abbrev-file-name           
      "~/.emacs.d/abbrev_defs")   
;;(add-hook 'text-mode-hook (lambda () (abbrev-mode 1)))
(setq save-abbrevs t)
(setq-default abbrev-mode t)

(global-set-key "\M-p" 'cperl-perldoc) ; alt-p

;; allow to use C-v, M-v, and C-l while searching
(setq isearch-allow-scroll t)    

(setq visible-bell t)
(setq ring-bell-function 'ignore)       ; ignore errors

(global-font-lock-mode t)		; syntax highlight
;;  语法高亮，除 shell-mode 和 text-mode 之外的模式中使用语法高亮
;;; (setq font-lock-maximum-decoration t)
;;; (setq font-lock-global-modes '(not shell-mode text-mode))
;;; (setq font-lock-verbose t)
;;; (setq font-lock-maximum-size
;;;       '((t . 1048576) (vm-mode . 5250000)))

;;设置 sentence-end 可以识别中文标点。不用在 fill 时在句号后插入两个空格。
(setq sentence-end "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")
(setq sentence-end-double-space nil)

(auto-image-file-mode t)                ; enable image viewing
(fset 'yes-or-no-p 'y-or-n-p)           ; ..

;;使用aspell程序作为emacs拼写检查程序
;;(setq-default ispell-program-name "aspell")

;;hippie-expand会优先使用表最前面的函数来补全。
(global-set-key [(meta ?/)] 'hippie-expand)
(setq hippie-expand-try-functions-list
      '(try-expand-line
        try-expand-line-all-buffers
        try-expand-list
        try-expand-list-all-buffers
        try-expand-dabbrev
        try-expand-dabbrev-visible
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-file-name
        try-complete-file-name-partially
        try-complete-lisp-symbol
        try-complete-lisp-symbol-partially
        try-expand-whole-kill))

(dolist (hook '(text-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))
(dolist (hook '(change-log-mode-hook log-edit-mode-hook))
  (add-hook hook (lambda () (flyspell-mode -1))))

(require 'tabbar)
(tabbar-mode)
;; move to previous group
(global-set-key (kbd "s-p") 'tabbar-backward-group)
(global-set-key [s-mouse-4] 'tabbar-backward-group)

;; move to next group
(global-set-key (kbd "s-n") 'tabbar-forward-group)
(global-set-key [s-mouse-5] 'tabbar-forward-group)

;; move to the left tab
(global-set-key (kbd "s-j") 'tabbar-backward)
(global-set-key [s-mouse-1] 'tabbar-backward)

;; move to the right tab
(global-set-key (kbd "s-k") 'tabbar-forward)
(global-set-key [s-mouse-3] 'tabbar-forward)
;; 组内循环滚动tab
(setq tabbar-cycling-scope (quote tabs))

;; 外观设置
;; tab内凹表明选定
;; set line number
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(tabbar-default-face ((t (:inherit variable-pitch :background "gray90" :foreground "gray60" :height 0.8))))
 '(tabbar-selected-face ((t (:inherit tabbar-default-face :foreground "darkred" :box (:line-width 2 :color "white" :style pressed-button)))))
 '(tabbar-unselected-face ((t (:inherit tabbar-default-face :foreground "black" :box (:line-width 2 :color "white" :style released-button))))))

;; (global-set-key (kbd "<s->") 'tabbar-backward-group)
;; (global-set-key (kbd "<s-p>") 'tabbar-forward-group)
;; (global-set-key (kbd "<s->") 'tabbar-backward)
;; (global-set-key (kbd "<s->") 'tabbar-forward)

(setq hostname (getenv "HOSTNAME"))     ; set hostname
;; disable the start splash
(setq inhibit-startup-message t)
;;(setenv "DISPLAY" "uniqueman:0")

(tool-bar-mode t)
(menu-bar-mode t)
(set-scroll-bar-mode nil)                   ; no scroll bar
(setq tool-bar-style 'image)

(setq initial-frame-alist
      '((top . 1) (left . 1) (width . 157) (height . 39)))

;; set scroll bar
;; (setq scroll-bar-mode 'right)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on) ;; shell 中打开 ansi-color 支持
(size-indication-mode t)		; display the size of the buffer
(line-number-mode t)                    ; line number in status bar
(require 'linum)                        ; print line number
(column-number-mode t)                  ; number of column
(show-paren-mode t)                     ; parenthesis
(display-time-mode t)                   ; show time
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(setq display-time-use-mail-icon t)     ;时间栏旁边启动邮件设置
;;时间的变化频率
(setq display-time-interval 10)
;; 设置时间戳，标识出最后一次保存文件的时间。
(setq time-stamp-active t)
(setq time-stamp-warn-inactive t)
;;(setq time-stamp-format "%:y-%02m-%02d %3a %02H:%02M:%02S Robert")
(setq time-stamp-start "[Ll]ast [Uu]pdated : ")
(setq time-stamp-format "%04y/%02m/%02d")
(setq time-stamp-end " \\|$")
(add-hook 'write-file-hooks 'time-stamp) ;; 自动更新 time-stamp
(add-hook 'before-save-hook 'time-stamp)
(mouse-avoidance-mode 'jump)

(blink-cursor-mode -1)
(transient-mark-mode -1)

;;防止页面滚动时跳动， scroll-margin 3 可以在靠近屏幕边沿3行时就开始滚动，
;;可以很好的看到上下文。
(setq scroll-margin 3
      scroll-conservatively 10000)

;;Turn off the status bar if we're not in a window system
;; (menu-bar-mode (if window-system 1 -1))

;;Make cursor stay in the same column when scrolling using pgup/dn.
;;Previously pgup/dn clobbers column position, moving it to the
;;beginning of the line.
;;http://www.dotemacs.de/dotfiles/ElijahDaniel.emacs.html
(defadvice scroll-up (around ewd-scroll-up first act)
  "Keep cursor in the same column."
  (let ((col (current-column)))
    ad-do-it
    (move-to-column col)))

(defadvice scroll-down (around ewd-scroll-down first act)
  "Keep cursor in the same column."
  (let ((col (current-column)))
    ad-do-it
    (move-to-column col)))

;;SavePlace- this puts the cursor in the last place you editted
;;a particular file. This is very useful for large files.
(require 'saveplace)
(setq-default save-place t)
(require 'speedbar)
;; definde speedbar
(defun my-speedbar ()
  "pop speedbar and modify frame size ."
  (interactive)
  (speedbar-frame-mode)
  (modify-frame-parameters nil
                           '((left + -4)
                             (top  + -4)
                             (width . 95)
                             (height . 48)))
  (modify-frame-parameters speedbar-frame
                           '((left + 895)
                             (top  + -4)
                             (width . 26)
                             (height . 28))))

;;;;  1. UI settings
;;;;  2. 
;;;;  3. key binding

;; the default outline-minor-mode key-binding prefix is too sophilicated.
;; C-o is bound to open-line by default
(setq outline-minor-mode-prefix [(control o)])

;; 为 view-mode 加入 vim 的按键。
(setq view-mode-hook
      (lambda ()
        (define-key view-mode-map "h" 'backward-char)
        (define-key view-mode-map "l" 'forward-char)
        (define-key view-mode-map "j" 'next-line)
        (define-key view-mode-map "k" 'previous-line)))

;; 这两个命令特别好用，可以根据文件的后缀或者 mode 判断调用的 compile
;; 命令。当目录下有 makefile 自动使用 make 命令。
(global-set-key (kbd "C-c r") 'smart-run)
(global-set-key (kbd "C-c m") 'smart-compile)
;; rectangle
(require 'rect-mark)
(global-set-key (kbd "C-x r C-@") 'rm-set-mark)
(global-set-key (kbd "C-x r C-z") 'rm-set-mark)
(global-set-key (kbd "C-x r C-x C-x") 'rm-exchange-point-and-mark)
(global-set-key (kbd "C-x r C-w") 'rm-kill-region)
(global-set-key (kbd "C-x r M-w") 'rm-kill-ring-save)
(global-set-key (kbd "C-x r C-y") 'yank-rectangle)


;;  C-o C-q hide-sublevels, M- n , C-o C-q
;;  C-o C-t hide-body, hide all entries, only show branch
;;  C-o C-a show-all 
;;  subtree hiding
;;  C-o C-d hide-subtree 
;;  C-o C-o hide-other
;;  C-o C-l hide-leaves: hide current lever entries 
;;  C-o C-c hiden-entry
;;  subtree showing
;;  C-o C-i show-children
;;  C-o C-e show-entry
;;  C-o C-k show-branches
;;  C-o C-s show-subtree
;;  Motion
;;  C-o C-n: outline-next-visible-heading
;;  C-o C-p: outline-previous-visible-heading
;;  C-o C-f: outline-forward-same-level
;;  C-o C-b: outline-backward-same-level
;;  C-o C-u: outline-up-heading
;; rebind c-m and c-j, let enter to be "newline-and-indent"
(global-set-key "\C-m" 'newline-and-indent)
(global-set-key "\C-j" 'newline)

;; register
(global-set-key (kbd "C-.") 'point-to-register)
(global-set-key (kbd "C-,") 'jump-to-register)
(setq show-trailing-whitespace t)

;; set dabbrev-expand
;;(Global-set-key (kbd "M-/") 'dabbrev-expand)

;; rebind 'C-x C-b' for ibuffer
;; by default, it's bound to buffer-menu-other-window'
(global-set-key "\C-x\C-b" 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)
;; hide all buffers starting with an asterisk.

;; classify the buffers by name or mode
(add-hook 'ibuffer-mode-hook (lambda ()
                               (setq ibuffer-filter-groups '(("*buffer*" (name . "\\*.*\\*"))
                                                             ("TAGS" (name . "^TAGS\\(<[0-9]+>\\)?$"))
                                                             ("dired" (mode . dired-mode))
                                                             ("Shell" (name . ".*\\.sh$"))
                                                             ("SQL" (name . ".*\\.sql$"))
                                                             ("ORG" (mode . org-mode))
                                                             ;; ("Shell" (mode . shell-script-mode))
                                                             ("java" (mode . java-mode))
                                                             ("ESS" (or (mode . ess-mode)
                                                                        (mode . iess-mode)))
                                                             ("MATLAB" (mode . matlab-mode))
                                                             ("ORG" (mode . org-mode))
                                                             ("Perl"  (mode . cperl-mode))
                                                             ("C/CPP"   (or (mode . c-mode)
                                                                            (mode . cpp-mode)
                                                                            (mode . c++-mode)))
                                                             ("Python" (mode . python-mode))
                                                             ("Latex" (mode . latex-mode))
                                                             ;;("FORTRAN" (mode . fortran-mode))
                                                             ("elisp" (or (mode . emacs-lisp-mode)
                                                                          (mode . lisp-interaction-mode)))
                                                             ))))

(setq ibuffer-saved-filters
      '(("t" ((or (mode . latex-mode)
                  (mode . plain-tex-mode))))
        ("c" ((or (mode . c-mode)
                  (mode . c++-mode))))
        ("p" ((mode . cperl-mode)))
        ("e" ((or (mode . emacs-lisp-mode)
                  (mode . lisp-interaction-mode))))
        ("d" ((mode . dired-mode)))
        ("s" ((mode . shell-mode)))
        ("i" ((mode . image-mode)))
        ("h" ((mode . html-mode)))
        ("gnus" ((or (mode . message-mode)
                     (mode . mail-mode)
                     (mode . gnus-group-mode)
                     (mode . gnus-summary-mode)
                     (mode . gnus-article-mode))))
        ("pr" ((or (mode . emacs-lisp-mode)
                   (mode . cperl-mode)
                   (mode . c-mode)
                   (mode . c++-mode)
                   (mode . php-mode)
                   (mode . java-mode)
                   (mode . idl-mode)
                   (mode . lisp-interaction-mode))))
        ("m" ((mode . muse-mode)))
        ("w" ((or (mode . emacs-wiki-mode)
                  (mode . muse-mode))))
        ("*" ((name . "*")))
        ))

;; hide all buffers starting with an asterisk
;; (add-to-list 'ibuffer-never-show-regexps "^\\*")
(global-set-key "\C-x\C-j" 'dired-jump) ; 何时候跳转到当前目录的 Dired buffer 中。
(global-set-key "\C-xk" 'kill-this-buffer) ; by default, it is bound to kill-buffer.
(global-set-key "\C-c\C-o" 'occur) ; occur 功能，列出当前 buffer 中匹配的行
(global-set-key "\C-c\C-v" 'view-mode) ; 查看文件，翻页比较方便，不用 C-v M-v 了。
(global-set-key "\C-c\C-z" 'pop-global-mark) ; 很多文件的时候，在几个文件中跳转到曾经用过的 mark 地方
(global-set-key "\C-\\" 'toggle-truncate-lines) ; 基本不用 Emacs 的输入法，绑定给折行命令吧
(global-set-key (kbd "C-SPC") nil) ; C-SPC is used for switching of input methods
(global-set-key "\C-z" 'set-mark-command) ; set mark, C-SPC and C-@ by default
(global-set-key [f1] 'help)
(global-set-key [s-f1] 'man)
;;C-x k is a command I use often, but C-x C-k (an easy mistake) is
;;bound to nothing!
;;Set C-x C-k to same thing as C-x k.
;;(global-set-key "\C-x\C-k" 'kill-this-buffer)

(global-set-key [(home)] 'beginning-of-buffer)
(global-set-key [(end)] 'end-of-buffer)

(global-set-key "\M-/" 'hippie-expand) ; 自动补全，hippie-expand, C-u M-/, previous
(global-set-key "\M-o" 'other-window) ; 除了在 Dired buffer 中，基本都可以用来 other-window。
;;(global-set-key "\M-n" 'gnus)               ; 启动新闻组客户端 gnus。
(global-set-key "\C-cw" 'compare-windows) ; compare windows

;; define key for info mode 
;; (define-key Info-mode-map "j" 'next-line)
;; (define-key Info-mode-map "k" 'previous-line)

;;;;  4. calendar configuration

;;设置所在地的经纬度和地名，calendar 可以根据这些信息告知你每天的
;;日出和日落的时间。
(setq calendar-latitude +31.8653)
(setq calendar-longitude +117.2797)
(setq calendar-location-name "Beijing")

(setq calendar-remove-frame-by-deleting t)
(setq calendar-week-start-day 1)        ; 每周第一天是周一
(setq mark-diary-entries-in-calendar t) ; 标记有记录的日子
(setq mark-holidays-in-calendar t)      ; 标记节假日
(setq view-calendar-holidays-initially nil) ; don't show holiday list
(setq appt-issue-message nil)
;;不过基督教的节日
(setq christian-holidays nil)
;;不过希伯来人的节日
(setq hebrew-holidays nil)
;;不过伊斯兰教的节日
(setq islamic-holidays nil)
;;不过太阳节
(setq solar-holidays nil)
;;要过的节日
(setq general-holidays '((holiday-fixed 1 1 "元旦")
                         (holiday-fixed 2 14 "情人节")
                         (holiday-fixed 5 1 "劳动节")
                         (holiday-float 5 0 2 "母亲节")
                         (holiday-float 6 0 3 "父亲节")
                         (holiday-fixed 10 1 "国庆节")
                         (holiday-fixed 3 8 "女朋友生日")
                         (holiday-fixed 9 28 "我的生日")))

;; Calendar 中 可以看到我们的阴历有中文的天干地支。
(setq chinese-calendar-celestial-stem
      ["甲" "乙" "丙" "丁" "戊" "己" "庚" "辛" "壬" "癸"])
(setq chinese-calendar-terrestrial-branch
      ["子" "丑" "寅" "卯" "辰" "巳" "午" "未" "申" "酉" "戌" "亥"])

;; 设置有用的个人信息.这在许多地方有用。
(setq user-full-name "Baotong Zhuang")
(setq user-mail-address "fengfu@taobao.com")

(setq diary-file "~/.emacs.d/.diary")
;; 默认的日记文件

;;;;  5. org-mode
(setq org-src-fontify-natively t)
(setq org-cycle-include-plain-lists t)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(global-set-key (kbd "C-c a") 'org-agenda)
(setq org-agenda-files '("~/.todo"))
(require 'org-element)
(require 'org-e-odt)
(require 'remember)

(add-hook 'remember-mode-hook 'org-remember-apply-template)
(setq remember-handler-functions '(org-remember-handler))

;;(Global-set-key (kbd "C-c r") 'remember)
(setq org-remember-templates '((?t "* TODO %?\n %u" "~/.todo")))

;;;;  6. C/CPP  Programming settings
;;(require 'cedet)
;;(semantic-mode t)
(require 'cc-mode)
(add-hook 'c-mode-hook 'linux-c-mode)
(add-hook 'c++-mode-hook 'linux-cpp-mode)

(add-hook 'c-mode-common-hook
          '(lambda ()
             (require 'xcscope)))

;; 设置imenu的排序方式为按名称排序
(setq imenu-sort-function 'imenu--sort-by-name)

(defun linux-c-mode()
  ;; 将回车代替C-j的功能，换行的同时对齐
  (define-key c-mode-map [return] 'newline-and-indent)
  (interactive)
  ;; 设置C程序的对齐风格
  (c-set-style "K&R")
  ;; 自动模式，在此种模式下当你键入{时，会自动根据你设置的对齐风格对齐
  (c-toggle-auto-state)
  ;; 此模式下，当按Backspace时会删除最多的空格
  (c-toggle-hungry-state)
  ;; indent by 4 spaces
  (setq c-basic-offset 4)
  ;; use spaces rather than tabs
  ;;  (indent-tabs-mode . nil)
  (setq-default indent-tabs-mode nil)
  ;; 在菜单中加入当前Buffer的函数索引
  (imenu-add-menubar-index)
  (local-set-key "\C-c\C-m" 'imenu)
  ;; 在状态条上显示当前光标在哪个函数体内部
  (which-function-mode)
  )

(defun linux-cpp-mode()
  (define-key c++-mode-map [return] 'newline-and-indent)
  (define-key c++-mode-map [(control c) (c)] 'compile)
  (interactive)
  (c-set-style "K&R")
  ;;   ;; custom indentation rules
  ;;   (c-offsets-alist . ((inline-open . 0) 
  ;;                       (brace-list-open . 0)
  ;;                       (statement-case-open . +)))
  (c-toggle-auto-state)
  (c-toggle-hungry-state)
  (setq c-basic-offset 4)
  (imenu-add-menubar-index)
  (local-set-key "\C-c\C-m" 'imenu)
  (which-function-mode)
  (require 'xcscope)
  )

;; flymake
(defun my-flymake-show-next-error() 
  (interactive)
  (flymake-goto-next-error)
  (flymake-display-err-menu-for-current-line)
  )

(local-set-key "\C-c\C-v" 'my-flymake-show-next-error)

(define-skeleton skeleton-c-mode-main-func
  "generate int main(int argc, char * argv[]) automatic" nil
  "int main (int argc, char * argv[]) \n{\n"
  > _  "\n" > "return 0;"
  "\n}")
(define-abbrev-table 'c-mode-abbrev-table '(
                                            ("main" "" skeleton-c-mode-main-func 1)
                                            ))


;;;;  7. my smart-snippet config
(require 'smart-snippet)
(setq save-abbrevs nil)

;;; for c++-mode

(smart-snippet-with-abbrev-tables
 (c++-mode-abbrev-table
  java-mode-abbrev-table)
 ("if" "if ($${condition}) {$>\n$>$.\n}$>" 'bol?)
 ("elsif" "else if ($${condition}) {$>\n$>$.\n}$>" 'bol?)
 ("else" "else {$>\n$>$.\n}$>" 'bol?)
 ("for" "for ($${init}; $${cond}; $${step}) {$>\n$>$.\n}$>" 'bol?)
 ("namespace" "namespace $${name} {\n$.\n} // namespace $${name}" 'bol?))

(smart-snippet-with-abbrev-tables
 (c++-mode-abbrev-table)
 ("class" "class $${name}\n{$>\npublic:$>\n$>$.\n};$>" 'bol?))

;; those non-word snippet can't be triggered by abbrev expand, we
;; need to bind them explicitly to some key
(smart-snippet-with-abbrev-tables
 (c++-mode-abbrev-table
  java-mode-abbrev-table)
 ("{" "{$.}" '(not (c-in-literal)))
 ("{" "{$>\n$>$.\n}$>" 'bol?)
 ;; if not in comment or other stuff(see `c-in-literal'), then
 ;; inser a pair of quote. if already in string, insert `\"'
 ("\"" "\"$.\"" '(not (c-in-literal)))
 ("\"" "\\\"$." '(eq (c-in-literal) 'string))
 ;; insert a pair of parenthesis, useful everywhere
 ("(" "($.)" t)
 ;; insert a pair of angular bracket if we are writing templates
 ("<" "<$.>" '(and (not (c-in-literal))
                   (looking-back "template[[:blank:]]*")))
 ;; a pair of square bracket, also useful everywhere
 ("[" "[$.]" t)
 ;; a pair of single quote, if not in literal
 ("'" "'$.'" '(not (c-in-literal)))
 )

(smart-snippet-with-keymaps
 ((c++-mode-map c++-mode-abbrev-table)
  (java-mode-map java-mode-abbrev-table))
 ("{" "{")
 ("\"" "\"")
 ("(" "(")
 ("<" "<")
 ("[" "[")
 ("'" "'")
 )

;; jump out from a pair(like quote, parenthesis, etc.)
(defun kid-c-escape-pair ()
  (interactive)
  (let ((pair-regexp "[^])}\"'>]*[])}\"'>]"))
    (if (looking-at pair-regexp)
        (progn
          ;; be sure we can use C-u C-@ to jump back
          ;; if we goto the wrong place
          (push-mark)
          (goto-char (match-end 0)))
      (c-indent-command))))

;; note TAB can be different to <tab> in X mode(not -nw mode).
;; the formal is C-i while the latter is the real "Tab" key in
;; your keyboard.
(define-key c++-mode-map (kbd "TAB") 'kid-c-escape-pair)
(define-key c++-mode-map (kbd "<tab>") 'c-indent-command)
;; snippet.el use TAB, now we need to use <tab>
(define-key snippet-map  (kbd "<tab>") 'snippet-next-field)

(define-key java-mode-map (kbd "<tab>") 'c-indent-command)
(define-key java-mode-map (kbd "TAB") 'kid-c-escape-pair)

;;(require 'doxymacs)
;;(add-hook 'c-mode-common-hook 'doxymacs-mode)
;; (defun my-doxymacs-font-lock-hook ()
;;   (if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
;;       (doxymacs-font-lock)))
;; (add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook)

;;;;  8. 
;;;;  9. AUCTeX
;; (setq auto-coding-alist
;;       (append auto-coding-alist '(("\\.tex\\'" . chinese-gbk))))
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

(setq TeX-newline-function 'reindent-then-newline-and-indent)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-install-toolbar)
(add-hook 'LaTeX-mode-hook 'turn-on-auto-fill)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(add-hook 'LaTeX-mode-hook 'outline-minor-mode)
(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
(add-hook 'LaTeX-mode-hook
          (lambda ()
            (local-set-key "\C-O" 'open-line)
            )
          )

(add-hook 'LaTeX-mode-hook
          (lambda()
            (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
            (setq TeX-command-default "XeLaTeX")
            (setq TeX-save-query  nil )
            (setq TeX-show-compilation t)
            )
          )

(setq LaTeX-section-hook
      '(LaTeX-section-heading
        LaTeX-section-title
        LaTeX-section-toc
        LaTeX-section-section
        LaTeX-section-label)
      )

(setq TeX-source-correlate-method 'synctex)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-command-list (quote (("XeLaTeX_SyncteX" "%`xelatex --synctex=1%(mode)%' %t" TeX-run-TeX nil (latex-mode doctex-mode) :help "Run XeLaTeX") ("TeX" "%(PDF)%(tex) %`%S%(PDFout)%(mode)%' %t" TeX-run-TeX nil (plain-tex-mode texinfo-mode ams-tex-mode) :help "Run plain TeX") ("LaTeX" "%`%l%(mode)%' %t" TeX-run-TeX nil (latex-mode doctex-mode) :help "Run LaTeX") ("Makeinfo" "makeinfo %t" TeX-run-compile nil (texinfo-mode) :help "Run Makeinfo with Info output") ("Makeinfo HTML" "makeinfo --html %t" TeX-run-compile nil (texinfo-mode) :help "Run Makeinfo with HTML output") ("AmSTeX" "%(PDF)amstex %`%S%(PDFout)%(mode)%' %t" TeX-run-TeX nil (ams-tex-mode) :help "Run AMSTeX") ("ConTeXt" "texexec --once --texutil %(execopts)%t" TeX-run-TeX nil (context-mode) :help "Run ConTeXt once") ("ConTeXt Full" "texexec %(execopts)%t" TeX-run-TeX nil (context-mode) :help "Run ConTeXt until completion") ("BibTeX" "bibtex %s" TeX-run-BibTeX nil t :help "Run BibTeX") ("View" "%V" TeX-run-discard-or-function nil t :help "Run Viewer") ("Print" "%p" TeX-run-command t t :help "Print the file") ("Queue" "%q" TeX-run-background nil t :help "View the printer queue" :visible TeX-queue-command) ("File" "%(o?)dvips %d -o %f " TeX-run-command t t :help "Generate PostScript file") ("Index" "makeindex %s" TeX-run-command nil t :help "Create index file") ("Check" "lacheck %s" TeX-run-compile nil (latex-mode) :help "Check LaTeX file for correctness") ("Spell" "(TeX-ispell-document \"\")" TeX-run-function nil t :help "Spell-check the document") ("Clean" "TeX-clean" TeX-run-function nil t :help "Delete generated intermediate files") ("Clean All" "(TeX-clean t)" TeX-run-function nil t :help "Delete generated intermediate and output files") ("Other" "" TeX-run-command t t :help "Run an arbitrary command") ("Jump to PDF" "%V" TeX-run-discard-or-function nil t :help "Run Viewer"))))
 '(TeX-modes (quote (tex-mode plain-tex-mode texinfo-mode latex-mode doctex-mode)))
 '(ede-project-directories (quote ("/home/baotong/workspace/mrank/plugins/bldrank" "/home/baotong/work/test/cpp")))
 '(ibus-cursor-type-for-candidate (quote box))
 '(idlwave-abbrev-change-case t)
 '(idlwave-default-font-lock-items (quote (pros-and-functions batch-files idlwave-idl-keywords label goto structtag structname common-blocks keyword-parameters system-variables class-arrows)))
 '(kill-whole-line nil)
 '(matlab-shell-command-switches (quote ("-nodesktop -nojvm -nosplash")))
 '(outline-minor-mode-prefix ""))

;; (Custom-set-variables
;;  '(LaTeX-command "latex -synctex=1")
;;  '(TeX-view-program-list (quote (("Skim" "/Applications/Skim.app/Contents/SharedSupport/displayline %n %o %b") ("Preview" "open -a Preview.app %o"))))
;; )

;;;; 10. general programming  setting
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode))
(add-hook 'yaml-mode-hook
          '(lambda ()
             (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

(require 'protobuf-mode)
(add-to-list 'auto-mode-alist '("\\.proto\\'" . protobuf-mode))

(require 'smart-compile+ nil t)
;;   %F  absolute pathname            ( /usr/local/bin/netscape.bin )
;;   %f  file name without directory  ( netscape.bin )
;;   %n  file name without extention  ( netscape )
;;   %e  extention of file name       ( bin )
(when (featurep 'smart-compile)
  (setq smart-compile-alist
        '(("\\.c$"          . "gcc -Wall -o %n %f")
          ("\\.[Cc]+[Pp]*$" . "g++ -Wall -o %n %f")
          ("\\.java$"       . "javac %f")
          ("\\.f90$"        . "f90 %f -o %n")
          ("\\.[Ff]$"       . "f77 %f -o %n")
          ("\\.mp$"         . "runmpost.pl %f -o ps")
          ("\\.php$"        . "php %f")
          ("\\.tex$"        . "latex %f")
          ("\\.l$"          . "lex -o %n.yy.c %f")
          ("\\.y$"          . "yacc -o %n.tab.c %f")
          ("\\.py$"         . "python %f")
          ("\\.sql$"        . "mysql < %f")
          ("\\.sh$"         . "./%f")
          (emacs-lisp-mode  . (emacs-lisp-byte-compile))))
  (setq smart-run-alist
        '(("\\.c$"          . "./%n")
          ("\\.[Cc]+[Pp]*$" . "./%n")
          ("\\.java$"       . "java %n")
          ("\\.php$"        . "php %f")
          ("\\.m$"          . "%f")
          ("\\.scm"         . "%f")
          ("\\.tex$"        . "dvisvga %n.dvi")
          ("\\.py$"         . "python %f")
          ("\\.sh$"         . "sh %f")
          ("\\.pl$"         . "perl %f")
          ("\\.pm$"         . "perl %f")
          ("\\.bat$"        . "%f")
          ("\\.mp$"         . "mpost %f")
          ("\\.sh$"         . "./%f")))
  (setq smart-executable-alist
        '("%n.class"
          "%n.exe"
          "%n"
          "%n.mp"
          "%n.m"
          "%n.php"
          "%n.scm"
          "%n.dvi"
          "%n.py"
          "%n.pl"
          "%n.ahk"
          "%n.pm"
          "%n.bat"
          "%n.sh")))

;;;; 11. ido setting
;;; {{{ ido: fast switch buffers
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(require 'ido)
(ido-mode t)

(add-hook 'ido-define-mode-map-hook 'ido-my-keys)

(defun ido-my-keys ()
  "Set up the keymap for `ido'."

  ;; common keys
  (define-key ido-mode-map "\C-e" 'ido-edit-input)
  (define-key ido-mode-map "\t" 'ido-complete) ;; complete partial
  (define-key ido-mode-map "\C-j" 'ido-select-text)
  (define-key ido-mode-map "\C-m" 'ido-exit-minibuffer)
  (define-key ido-mode-map "?" 'ido-completion-help) ;; list completions
  (define-key ido-mode-map [(control ? )] 'ido-restrict-to-matches)
  (define-key ido-mode-map [(control ?@)] 'ido-restrict-to-matches)

  ;; cycle through matches
  (define-key ido-mode-map "\C-r" 'ido-prev-match)
  (define-key ido-mode-map "\C-s" 'ido-next-match)
  (define-key ido-mode-map [right] 'ido-next-match)
  (define-key ido-mode-map [left] 'ido-prev-match)

  ;; toggles
  (define-key ido-mode-map "\C-t" 'ido-toggle-regexp) ;; same as in isearch
  (define-key ido-mode-map "\C-p" 'ido-toggle-prefix)
  (define-key ido-mode-map "\C-c" 'ido-toggle-case)
  (define-key ido-mode-map "\C-a" 'ido-toggle-ignore)

  ;; keys used in file and dir environment
  (when (memq ido-cur-item '(file dir))
    (define-key ido-mode-map "\C-b" 'ido-enter-switch-buffer)
    (define-key ido-mode-map "\C-d" 'ido-enter-dired)
    (define-key ido-mode-map "\C-f" 'ido-fallback-command)

    ;; cycle among directories
    ;; use [left] and [right] for matching files
    (define-key ido-mode-map [down] 'ido-next-match-dir)
    (define-key ido-mode-map [up]   'ido-prev-match-dir)

    ;; backspace functions
    (define-key ido-mode-map [backspace] 'ido-delete-backward-updir)
    (define-key ido-mode-map "\d"        'ido-delete-backward-updir)
    (define-key ido-mode-map [(meta backspace)] 'ido-delete-backward-word-updir)
    (define-key ido-mode-map [(control backspace)] 'ido-up-directory)

    ;; I can't understand this
    (define-key ido-mode-map [(meta ?d)] 'ido-wide-find-dir)
    (define-key ido-mode-map [(meta ?f)] 'ido-wide-find-file)
    (define-key ido-mode-map [(meta ?k)] 'ido-forget-work-directory)
    (define-key ido-mode-map [(meta ?m)] 'ido-make-directory)

    (define-key ido-mode-map [(meta down)] 'ido-next-work-directory)
    (define-key ido-mode-map [(meta up)] 'ido-prev-work-directory)
    (define-key ido-mode-map [(meta left)] 'ido-prev-work-file)
    (define-key ido-mode-map [(meta right)] 'ido-next-work-file)

    ;; search in the directories
    ;; use C-_ to undo this
    (define-key ido-mode-map [(meta ?s)] 'ido-merge-work-directories)
    (define-key ido-mode-map [(control ?\_)] 'ido-undo-merge-work-directory)
    )

  (when (eq ido-cur-item 'file)
    (define-key ido-mode-map "\C-k" 'ido-delete-file-at-head)
    (define-key ido-mode-map "\C-l" 'ido-toggle-literal)
    (define-key ido-mode-map "\C-o" 'ido-copy-current-word)
    (define-key ido-mode-map "\C-v" 'ido-toggle-vc)
    (define-key ido-mode-map "\C-w" 'ido-copy-current-file-name)
    )

  (when (eq ido-cur-item 'buffer)
    (define-key ido-mode-map "\C-b" 'ido-fallback-command)
    (define-key ido-mode-map "\C-f" 'ido-enter-find-file)
    (define-key ido-mode-map "\C-k" 'ido-kill-buffer-at-head)
    ))

;;; }}}
;;;; 12.
;;;; 13. sql/hive/odps settings
;;;; hive mode
(require 'sql)

(eval-after-load "sql"
  (load-library "sql-indent"))

;; TODO: 增加格式化时, 自动关键字大写
(add-hook 'sql-mode-hook (lambda ()
                           (abbrev-mode t)
                           ))
(define-abbrev-table 'sql-mode-abbrev-table
  (mapcar #'(lambda (v) (list v (upcase v) nil 1))
          '("absolute" "action" "add" "after" "all" "allocate" "alter" "and" "any" "are" "array" "as" "asc" "asensitive"
            "assertion" "asymmetric" "at" "atomic" "authorization" "avg" "before" "begin" "between" "bigint" "binary" "bit"
            "bitlength" "blob" "boolean" "both" "breadth" "by" "call" "called" "cascade" "cascaded" "case" "cast" "catalog"
            "char" "char_length" "character" "character_length" "check" "clob" "close" "coalesce" "collate" "collation"
            "column" "commit" "condition" "connect" "connection" "constraint" "constraints" "constructor" "contains"
            "continue" "convert" "corresponding" "count" "create" "cross" "cube" "current" "current_date"
            "current_default_transform_group" "current_path" "current_role" "current_time" "current_timestamp"
            "current_transform_group_for_type" "current_user" "cursor" "cycle" "data" "date" "day" "deallocate" "dec"
            "decimal" "declare" "default" "deferrable" "deferred" "delete" "depth" "deref" "desc" "describe" "descriptor"
            "deterministic" "diagnostics" "disconnect" "distinct" "do" "domain" "double" "drop" "dynamic" "each" "element"
            "else" "elseif" "end" "equals" "escape" "except" "exception" "exec" "execute" "exists" "exit" "external" "extract"
            "false" "fetch" "filter" "first" "float" "for" "foreign" "found" "free" "from" "full" "function" "general" "get"
            "global" "go" "goto" "grant" "group" "grouping" "handler" "having" "hold" "hour" "identity" "if" "immediate" "in"
            "indicator" "initially" "inner" "inout" "input" "insensitive" "insert" "int" "integer" "intersect" "interval"
            "into" "is" "isolation" "iterate" "join" "key" "language" "large" "last" "lateral" "leading" "leave" "left" "level"
            "like" "local" "localtime" "localtimestamp" "locator" "loop" "lower" "map" "match" "map" "member" "merge" "method"
            "min" "minute" "modifies" "module" "month" "multiset" "names" "national" "natural" "nchar" "nclob" "new" "next"
            "no" "none" "not" "null" "nullif" "numeric" "object" "octet_length" "of" "old" "on" "only" "open" "option" "or" "overwrite"
            "order" "ordinality" "out" "outer" "output" "over" "overlaps" "pad" "parameter" "partial" "partition" "path"
            "position" "precision" "prepare" "preserve" "primary" "prior" "privileges" "procedure" "public" "range" "read"
            "reads" "real" "recursive" "ref" "references" "referencing" "relative" "release" "repeat" "resignal" "restrict"
            "result" "return" "returns" "revoke" "right" "role" "rollback" "rollup" "routine" "row" "rows" "savepoint" "schema"
            "scope" "scroll" "search" "second" "section" "select" "sensitive" "session" "session_user" "set" "sets" "signal" "string"
            "similar" "size" "smallint" "some" "space" "specific" "specifictype" "sql" "sqlcode" "sqlerror" "sqlexception"
            "sqlstate" "sqlwarning" "start" "state" "static" "submultiset" "substring" "sum" "symmetric" "system" "system_user"
            "table" "tablesample" "temporary" "then" "time" "timestamp" "timezone_hour" "timezone_minute" "to" "trailing"
            "transaction" "translate" "translation" "treat" "trigger" "trim" "true" "under" "undo" "union" "unique" "unknown"
            "unnest" "until" "update" "upper" "usage" "using" "value" "values" "varchar" "varying" "view" "when" "whenever"
            "where" "while" "window" "with" "within" "without" "work" "write" "year" "zone" "partitioned" "comment")
          ))

(defvar sql-mode-hive-font-lock-keywords
  (eval-when-compile
    (list
     ;; hive Functions
     (sql-font-lock-keywords-builder 'font-lock-builtin-face nil
"ascii" "avg" "bdmpolyfromtext" "bdmpolyfromwkb" "bdpolyfromtext"
"bdpolyfromwkb" "benchmark" "bin" "bit_and" "bit_length" "bit_or"
"bit_xor" "both" "cast" "char_length" "character_length" "coalesce"
"concat" "concat_ws" "connection_id" "conv" "convert" "count"
"curdate" "current_date" "current_time" "current_timestamp" "curtime"
"elt" "encrypt" "export_set" "field" "find_in_set" "found_rows"
"geomcollfromtext" "geomcollfromwkb" "geometrycollectionfromtext"
"geometrycollectionfromwkb" "geometryfromtext" "geometryfromwkb"
"geomfromtext" "geomfromwkb" "get_lock" "group_concat" "hex" "ifnull"
"instr" "interval" "isnull" "last_insert_id" "lcase" "leading"
"length" "linefromtext" "linefromwkb" "linestringfromtext"
"linestringfromwkb" "load_file" "locate" "lower" "lpad" "ltrim"
"make_set" "master_pos_wait" "max" "mid" "min" "mlinefromtext"
"mlinefromwkb" "mpointfromtext" "mpointfromwkb" "mpolyfromtext"
"mpolyfromwkb" "multilinestringfromtext" "multilinestringfromwkb"
"multipointfromtext" "multipointfromwkb" "multipolygonfromtext"
"multipolygonfromwkb" "now" "nullif" "oct" "octet_length" "ord"
"pointfromtext" "pointfromwkb" "polyfromtext" "polyfromwkb"
"polygonfromtext" "polygonfromwkb" "position" "quote" "rand"
"release_lock" "repeat" "replace" "reverse" "rpad" "rtrim" "soundex"
"space" "std" "stddev" "substring" "substring_index" "sum" "sysdate"
"trailing" "trim" "ucase" "unix_timestamp" "upper" "user" "variance"
)

     ;; hive Keywords
     (sql-font-lock-keywords-builder 'font-lock-keyword-face nil
"stored" "sequencefile" "local" "overwrite" "external" "action"
"add" "after" "against" "all" "alter" "and" "as" "asc"
"auto_increment" "avg_row_length" "bdb" "between" "by" "cascade"
"case" "change" "character" "check" "checksum" "close" "collate"
"collation" "column" "columns" "comment" "committed" "concurrent"
"constraint" "create" "cross" "data" "database" "default"
"delay_key_write" "delayed" "delete" "desc" "directory" "disable"
"distinct" "distinctrow" "do" "drop" "dumpfile" "duplicate" "else" "elseif"
"enable" "enclosed" "end" "escaped" "exists" "fields" "first" "for"
"force" "foreign" "from" "full" "fulltext" "global" "group" "handler"
"having" "heap" "high_priority" "if" "ignore" "in" "index" "infile"
"inner" "insert" "insert_method" "into" "is" "isam" "isolation" "join"
"key" "keys" "last" "left" "level" "like" "limit" "lines" "load"
"local" "lock" "low_priority" "match" "max_rows" "merge" "min_rows"
"mode" "modify" "mrg_myisam" "myisam" "natural" "next" "no" "not"
"null" "offset" "oj" "on" "open" "optionally" "or" "order" "outer"
"outfile" "pack_keys" "partial" "password" "prev" "primary"
"procedure" "quick" "raid0" "raid_type" "read" "references" "rename"
"repeatable" "restrict" "right" "rollback" "rollup" "row_format"
"savepoint" "select" "separator" "serializable" "session" "set"
"share" "show" "sql_big_result" "sql_buffer_result" "sql_cache"
"sql_calc_found_rows" "sql_no_cache" "sql_small_result" "starting"
"straight_join" "striped" "table" "tables" "temporary" "terminated"
"then" "to" "transaction" "truncate" "type" "uncommitted" "union"
"unique" "unlock" "update" "use" "using" "values" "when" "where"
"with" "write" "xor" "overwrite"
)

     ;; hive Data Types
     (sql-font-lock-keywords-builder 'font-lock-type-face nil
"string" "bigint" "binary" "bit" "blob" "bool" "boolean" "char" "curve" "date"
"datetime" "dec" "decimal" "double" "enum" "fixed" "float" "geometry"
"geometrycollection" "int" "integer" "line" "linearring" "linestring"
"longblob" "longtext" "mediumblob" "mediumint" "mediumtext"
"multicurve" "multilinestring" "multipoint" "multipolygon"
"multisurface" "national" "numeric" "point" "polygon" "precision"
"real" "smallint" "surface" "text" "time" "timestamp" "tinyblob"
"tinyint" "tinytext" "unsigned" "varchar" "year" "year2" "year4"
"zerofill"
)))

  "HIVE SQL keywords used by font-lock.

This variable is used by `sql-mode' and `sql-interactive-mode'.  The
regular expressions are created during compilation by calling the
function `regexp-opt'.  Therefore, take a look at the source before
you define your own `sql-mode-mysql-font-lock-keywords'.")

(defcustom sql-hive-options nil
  "List of additional options for `sql-hive-program'."
  :type '(repeat string)
  :group 'SQL)

(defcustom sql-hive-program "/home/baotong/odps/bin/odpscmd"
  "Command to start ihive by hive."
  :type 'file
  :group 'SQL)

(defcustom sql-hive-login-params nil
  "List of login parameters needed to connect to MySQL."
  :type 'sql-login-params
  :version "24.1"
  :group 'SQL)

(sql-add-product 'hive "HIVE"
                 :free-software t
                 :font-lock sql-mode-hive-font-lock-keywords
                 :sqli-program sql-hive-program
                 :sqli-options sql-hive-options
                 :sqli-login sql-hive-login-params
                 :statement sql-ansi-statement-starters
                 :list-all "SHOW TABLES;"
                 :list-table "DESCRIBE %s;"
                 :prompt-regexp "^odps> "
                 :prompt-cont-regexp "^    -> "
                 :syntax-alist nil
                 :prompt-length 7
                 :input-filter 'sql-remove-tabs-filter
                 )


(defun sql-comint-hive (product options)
  "Connect ti HiveDB in a comint buffer."
    (let ((params))
      (sql-comint product params)))

(sql-set-product-feature 'hive
                         :sqli-comint-func 'sql-comint-hive)

(defun sql-hive (&optional buffer)
  "Run ihive by HiveDB as an inferior process."
  (interactive "P")
  (sql-product-interactive 'hive buffer))


;;;; 14. matlab settings
;; this variable is undefined, if gdb process is not running
(set-default 'gdb-active-process nil)
(autoload 'matlab-mode "matlab" "Enter MATLAB mode." t)
;;(setq auto-mode-alist (cons '("\\.m\\'" . matlab-mode) auto-mode-alist))
(add-to-list 'auto-mode-alist '("\\.m\\'" . matlab-mode))
(autoload 'matlab-shell "matlab" "Interactive MATLAB mode." t)
;;(setq matlab-indent-function-body t)  ; if you want function bodies indented
(setq matlab-verify-on-save-flag nil) ; turn off auto-verify on save
(defun my-matlab-mode-hook ()
  (setq fill-column 96)); where auto-fill should wrap
(add-hook 'matlab-mode-hook 'my-matlab-mode-hook)
(defun my-matlab-shell-mode-hook ()
  '())
(add-hook 'matlab-shell-mode-hook 'my-matlab-shell-mode-hook)

;; Matlab Shell Command Switches: Show Value
;;    State: HIDDEN, invoke "Show" in the previous line to show.
;;    Command line parameters run with `matlab-shell-command'.
;; matlab-shell-command-switches: Hide Value '("-nodesktop -nojvm -nosplash")
;;    State: CHANGED outside Customize; operating on it here may be unreliable. (mismatch)
;;    Command line parameters run with `matlab-shell-command'.

;;;; 15. R/ESS
;;(add-to-list 'auto-mode-alist '("\\.R$'" . R-mode))
(autoload 'R-mode "ess-site" "Enter R mode." t)
(require 'ess-site)
(setq ess-eval-visibly-p nil) ;otherwise C-c C-r (eval region) takes forever
(setq ess-ask-for-ess-directory nil) ;otherwise you are prompted each time you start an interactive R session
(require 'ess-eldoc) ;to show function arguments while you are typing them

;;;; 16. golang
(require 'go-mode-load)
;;;; elisp functions
;; Useful for logging times  in job notes, etc. The date function
;; Added Thu Apr 16 15:39:12 EST 1987 :-)
(defun current-date-and-time ()
  "Insert the current date and time (as given by UNIX date) at dot."
  (interactive)
  (call-process "date" nil t nil))

;; This function will format the whole file for you
(defun indent-whole-buffer ()
  (interactive)
  (indent-region (point-min) (point-max) nil))

;; file-length is easier to remember than count-lines-page
;; And I wrote it so that makes it even better
(defun file-length ()
  "Prints the file length"
  (interactive)
  (message "%s is %d lines long" (buffer-name) (count-lines (point-min) (point-max) )))

;; The name says it all
(defun switch-to-previous-buffer ()
  (interactive)
  (switch-to-buffer (other-buffer)))

;; The name says it all
(defun kill-current-buffer ()
  (interactive)
  (kill-buffer  (current-buffer)))

;; Reusable code templates.
(defun c-functions-comment () 
  "Insert a c functions comment template"
  (interactive)
  (insert "///////////////////////  ")
  (push-mark)
  (insert "  ///////////////////////")
  )

(defun c-file-header-comment ()
  "Insert a tag looking c file header comment template "
  (interactive)
  (insert "///////////////////////////////////////////////////////\n")
  (insert "//   Filename:")
  (insert (buffer-name))
  (insert"                                  \\\\\n")
  (insert "//                                                   //\n")
  (insert "//   Subject:")
  (insert "                                        \\\\\n")
  (insert "//                                                   //\n")
  (insert "//   Author:")
  (insert "                                         \\\\\n")
  (insert "//                                                   //\n")
  (insert "//                                                   \\\\\n")
  (insert "//                                                   //\n")
  (insert "//////////////////////////////////////////////////////\n")
  )

;;copy current line
(defun zwl-copy-current-line ()
  "Copy current line to kill-ring"
  (interactive)
  (kill-ring-save (line-beginning-position) (line-end-position)))

(define-key global-map (kbd "C-c y") 'zwl-copy-current-line)


(defun wy-go-to-char (n char)
  "Move forward to Nth occurence of CHAR.
Typing `wy-go-to-char-key' again will move forwad to the next Nth
occurence of CHAR."
  (interactive "p\ncGo to char: ")
  (search-forward (string char) nil nil n)
  (while (char-equal (read-char)
                     char)
    (search-forward (string char) nil nil n))
  (setq unread-command-events (list last-input-event)))

(define-key global-map (kbd "C-c a") 'wy-go-to-char)

;;perl
(defalias 'perl-mode 'cperl-mode)

;; php mode
(require 'php-mode)

;; evernote setting
(setq evernote-enml-formatter-command '("w3m" "-dump" "-I" "UTF8" "-O" "UTF8")) ; option
                                        ;(add-to-list 'load-path "<your load path>")
(require 'markdown-mode)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; (require 'evernote-mode)
;; (global-set-key "\C-cec" 'evernote-create-note)
;; (global-set-key "\C-ceo" 'evernote-open-note)
;; (global-set-key "\C-ces" 'evernote-search-notes)
;; (global-set-key "\C-ceS" 'evernote-do-saved-search)
;; (global-set-key "\C-cew" 'evernote-write-note)
;; (global-set-key "\C-cep" 'evernote-post-region)
;; (global-set-key "\C-ceb" 'evernote-browser)

;; 4 space indents in cperl mode

;; '(cperl-close-paren-offset -4)
;; '(cperl-continued-statement-offset 4)
;; '(cperl-indent-level 4)
;; '(cperl-indent-parens-as-block t)
;; '(cperl-tab-always-indent t)

;; Local Variables:
;; mode: outline-minor
;; fill-column: 78
;; outline-regexp: ";;;;+"
;; page-delimiter: "^;;;;"
;; End:

;;(put 'dired-find-alternate-file 'disabled nil)
