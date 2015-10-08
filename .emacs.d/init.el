
;;; This file bootstraps the configuration, which is divided into
;;; a number of other files.

(let ((minver "23.3"))
  (when (version<= emacs-version "23.1")
    (error "Your Emacs is too old -- this config requires v%s or higher" minver)))
(when (version<= emacs-version "24")
  (message "Your Emacs is old, and some functionality in this config will be disabled. Please upgrade if possible."))

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
;(require 'init-benchmarking) ;; Measure startup time

(defconst *spell-check-support-enabled* nil) ;; Enable with t if you prefer
(defconst *is-a-mac* (eq system-type 'darwin))

;----------------------------------------------------------------------------
; Bootstrap config
;----------------------------------------------------------------------------
;(require 'init-compat)

;(add-to-list 'load-path "~/.emacs.d/el-get")  

;(unless (require 'el-get nil t)
;   (url-retrieve
;     "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
;     (lambda (s) (end-of-buffer) (eval-print-last-sexp))))


(load-file "~/.emacs.d/el-get/dash/dash.el")
(require 'dash)


(add-to-list 'load-path "~/.emacs.d/evil") 
(require 'evil) 
(evil-mode 1) ;以上的是设置启动emacs载入evil 

(setq evil-default-state 'normal) 
;这个是打开文件后默认进入emacs模式 
;我还要在emacs和vim模式里面切换：C-z，换来换去啊 

;(define-key evil-emacs-state-map (kbd "C-o") 'evil-execute-in-normal-state) 
; C-o按键调用vim功能（就是临时进入normal模式，然后自动回来） 
; 比如，你要到第一行，可以使用emacs的 M-<，也可以使用evil的C-o gg 
; 其中C-o是进入vim模式 gg是去第一行，命令之后自动还原emacs模式！ 
; "Fuck you!" 如何删除""里面的内容呢？Emacs的话，默认文本对象能力不强 
; 有了evil的拓展 C-o di" 轻轻松松搞定~ 
; 比如C-o 3dd C-o dib C-o yy C-o p C-o f * 舒服啊~发挥想象力吧 

; 下面4行是设置使用C-d作为ESC按键，这个自己看吧 
;(define-key evil-insert-state-map (kbd "C-d") 'evil-change-to-previous-state) 
;(define-key evil-normal-state-map (kbd "C-d") 'evil-force-normal-state) 
;(define-key evil-replace-state-map (kbd "C-d") 'evil-normal-state) 
;(define-key evil-visual-state-map (kbd "C-d") 'evil-exit-visual-state) 

; 以下设置时使用t作为多剪贴板的起始按键，比如 tay(不是 "ay哦) tap(就是"ap啦)~ 
;(define-key evil-normal-state-map "t" 'evil-use-register) 

; 注意，如果有什么bug的话，把这个函数也添加了 
; evil作者给的代码，不知道有没有添加到插件里面去 
;(defun evil-execute-in-normal-state () 
; "Execute the next command in Normal state. C-o o works in insert-mode" 
; (interactive) 
; (evil-delay '(not (memq this-command 
; '(evil-execute-in-normal-state 
; evil-use-register 
; digit-argument 
; negative-argument 
; universal-argument 
; universal-argument-minus 
; universal-argument-more 
; universal-argument-other-key))) 
; `(progn 
; (if (evil-insert-state-p) 
; (let ((prev-state (cdr-safe (assoc 'normal evil-previous-state-alist)))) 
; (evil-change-state prev-state) 
; (setq evil-previous-state 'normal)) 
; (evil-change-to-previous-state)) 
; (setq evil-move-cursor-back ',evil-move-cursor-back)) 
; 'post-command-hook) 
; (setq evil-move-cursor-back nil) 
; (evil-normal-state) 
; (evil-echo "Switched to Normal state for the next command ..."))
;
;(require 'cc-mode)

;
;(setq cscope-do-not-update-database t)
;
;
;(add-to-list 'load-path "~/.emacs.d/sr-speedbar/") 
;(require 'sr-speedbar)  
;(setq speedbar-show-unknown-files t)  
;(setq speedbar-use-images nil)  
;(setq sr-speedbar-width 30)  
;(setq sr-speedbar-right-side nil)  
   
;;(global-set-key (kbd "<f5>") (lambda()  (interactive)  (sr-speedbar-toggle)))  
;;----------------------------------------------------------------------------
;; Locales (setting them earlier in this file doesn't work in X)
;;----------------------------------------------------------------------------
;;(require 'init-locales)

;;(add-hook 'after-init-hook
;;          (lambda ()
;;            (message "init completed in %.2fms"
;;                     (sanityinc/time-subtract-millis after-init-time before-init-time))))
;;
;;
;;(provide 'init)
;;(global-set-key "%" 'match-paren)
;;;; match (, {, blank          
;;(defun match-paren (arg)
;;  "Go to the matching paren if on a paren; otherwise insert %."
;;  (interactive "p")
;;bal-set-key [(control ?\.)] 'ska-point-to-register)
;;(global-set-key [(control ?\,)] 'ska-jump-to-register)
;;(defun ska-point-to-register()
;;  "Store cursorposition _fast_ in a register. 
;;Use ska-jump-to-register to jump back to the stored 
;;position."
;;  (interactive)
;;  (setq zmacs-region-stays t)
;;  (point-to-register 8))
;;
;;(defun ska-jump-to-register()
;;  "Switches between current cursorposition and position
;;that was stored with ska-point-to-register."
;;  (interactive)
;;  (setq zmacs-region-stays t)
;;  (let ((tmp (point-marker)))
;;        (jump-to-register 8)
;;        (set-register 8 tmp)))
;;
;;  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
;;	((looking-at "\\s\)") (forward-char 1) (backward-list 1))
;;	(t (self-insert-command (or arg 1)))))
;;;; Got a char 
;;(defun wy-go-to-char (n char)
;;  "Move forward to Nth occurence of CHAR.
;;Typing `wy-go-to-char-key' again will move forwad to the next Nth
;;occurence of CHAR."
;;  (interactive "p\ncGo to char: ")
;;  (search-forward (string char) nil nil n)
;;  (while (char-equal (read-char)
;;		     char)
;;    (search-forward (string char) nil nil n))
;;  (setq unread-command-events (list last-input-event)))
;;
;;(define-key global-map (kbd "C-c a") 'wy-go-to-char)
;;(require 'ctypes)
;;(ctypes-auto-parse-mode 1)
;;
;;((require 'setnu)
;;(custom-set-variables
;; ;; custom-set-variables was added by Custom.
;; ;; If you edit it by hand, you could mess it up, so be careful.
;; ;; Your init file should contain only one such instance.
;; ;; If there is more than one, they won't work right.
;; '(custom-safe-themes (quote ("4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" default)))
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.


(defun my-c-mode-hook()
(modify-syntax-entry ?_"w"))

(add-hook 'c-mode-hook 'my-c-mode-hook)


;(setq
;  el-get-sources ;; 說明-1
;  '(el-get ;; 說明-2
;     (:name smex
;            :after (progn ;; 說明-3
;                     (global-set-key (kbd "M-x") 'smex)
;                     (global-set-key (kbd "M-X") 'smex-major-mode-commands)))
;     (:name magit
;            :after (global-set-key (kbd "C-x C-z") 'magit-status))))
;
;;; 設定要安裝的包！這裡是重點，下面解釋：
;(setq packages
;      (append
;        '(el-get smex magit ;; 說明-4
;                 paredit python-mode web-mode go-mode
;        (mapcar 'el-get-source-name el-get-sources)))
;
;; 這裡是設定重點，包含異步/同步啟動機制
;(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
; '(custom-safe-themes (quote ("4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" default))))
;(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")  

(unless (require 'el-get nil t)
   (url-retrieve
     "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
     (lambda (s) (end-of-buffer) (eval-print-last-sexp))))

(add-to-list 'load-path "~/.emacs.d/el-get/projectile")

(require 'projectile)

;; 默认全局使用
(projectile-global-mode)
;; 默认打开缓存
;(setq projectile-enable-caching nil)
(setq projectile-enable-caching t)
;; 使用f5键打开默认文件搜索
(global-set-key [f5] 'projectile-find-file)

(add-to-list 'load-path "~/.emacs.d/el-get")
;(setq
;  el-get-sources ;; 說明-1
;  '(el-get ;; 說明-2
;     (:name smex
;            :after (progn ;; 說明-3
;                     (global-set-key (kbd "M-x") 'smex)
;                     (global-set-key (kbd "M-X") 'smex-major-mode-commands)))
;     (:name magit
;            :after (global-set-key (kbd "C-x C-z") 'magit-status))))
;(el-get 'sync packages)
;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;;smex
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

(set-language-environment 'Chinese-GB)
(set-keyboard-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-selection-coding-system 'utf-8)
(modify-coding-system-alist 'process "*" 'utf-8)
(setq default-process-coding-system '(utf-8 . utf-8))
(setq-default pathname-coding-system 'utf-8)
(set-file-name-coding-system 'utf-8)
(setq ansi-color-for-comint-mode t)

(ido-mode t)
(setq column-number-mode t)
(setq line-number-mode t)
(show-paren-mode t)
;; End:
