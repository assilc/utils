(add-to-list 'load-path "~/.emacs.d/lisp/")
;; start gnuserv stuff. Put it up front so you don't get into a
;; timeout problem when starting emacs from gnuclient or gnudoit,
;; according to Cristian Ionescu-Idbohrn
;; <cristian.ionescu-idbohrn@axis.com>
(setq shell-file-name "bash")
(if (string-equal system-type "gnu/linux")
    ;;     (or (string-equal (getenv "OSTYPE") "Linux" )
    ;; 	(string-equal (getenv "OSTYPE") "linux-gnu" ))
    (server-start)
  (message "emacsserver started."))

					; end gnuserv stuff

(custom-set-variables
 '(border ((t nil)))
 '(cursor ((t (:background "#f0e0d0"))))
 '(font-lock-builtin-face ((((class color) (min-colors 88) (background dark)) (:background "black" :foreground "LightSteelBlue"))))
 '(font-lock-comment-delimiter-face ((((class color) (min-colors 88) (background dark)) (:background "#303030" :foreground "#909090"))))
 '(font-lock-comment-face ((((class color) (min-colors 88) (background dark)) (:background "#303030" :foreground "#607080"))))
 '(font-lock-constant-face ((((class color) (min-colors 88) (background dark)) (:foreground "#ffffff" :weight bold))))
 '(font-lock-function-name-face ((((class color) (min-colors 88) (background dark)) (:foreground "SkyBlue" :weight bold :height 1.0))))
 '(font-lock-keyword-face ((((class color) (min-colors 88) (background dark)) (:background "black" :foreground "Cyan1"))))
 '(font-lock-negation-char-face ((t (:foreground "#ff0000"))))
 '(font-lock-preprocessor-face ((t (:inherit font-lock-builtin-face :background "#20e020" :foreground "#e020e0"))))
 '(font-lock-string-face ((((class color) (min-colors 88) (background dark)) (:background "#004040" :foreground "#ffa0a0"))))
 '(font-lock-type-face ((((class color) (min-colors 88) (background dark)) (:foreground "#ffffff" :weight bold))))
 '(font-lock-variable-name-face ((((class color) (min-colors 88) (background dark)) (:foreground "#f0e7e0"))))
 '(highlight ((((class color) (min-colors 88) (background dark)) (:stipple "" :background "#000000"))))
 '(mode-line ((((class color) (min-colors 88)) (:background "#50a0f0" :foreground "black" :box (:line-width -1 :style released-button)))))
 '(scroll-bar ((t nil))))



(setq default-tab-width 2)
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(setq cc-other-file-alist
      '(("\\.c"   (".h"))
       ("\\.cpp"   (".h"))
       ("\\.h"   (".cpp"".c"))))


(setq w32-use-w32-font-dialog nil)
(setq-default truncate-lines t)

(put 'scroll-left 'disabled nil)
;; ===== Set the highlight current line minor mode =====

;; In every buffer, the line which contains the cursor will be fully
;; highlighted

(global-hl-line-mode 1)
;; This makes the buffer scroll by only a single line when the up or
;; down cursor keys push the cursor (tool-bar-mode) outside the
;; buffer. The standard emacs behaviour is to reposition the cursor in
;; the center of the screen, but this can make the scrolling confusing

(setq scroll-step 1)

;; Show column-number in the mode line
(column-number-mode 1)

;; warn when opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)



;;;  -------------------  Test Functions --------------
(defun count-words-region (beginning end)
  "Print number of words in the region."
  (called-interactively "r")
  (message "Counting words in region ... ")

;; 1. Set up appropriate conditions.
  (save-excursion
    (let ((count 0))
      (goto-char beginning)

;; 2. Run the while loop.
      (while (and (< (point) end)
                  (re-search-forward "\\w+\\W*" end t))
        (setq count (1+ count)))

;; 3. Send a message to the user.
      (cond ((zerop count)
             (message
              "The region does NOT have any words."))
            ((= 1 count)
             (message
              "The region has 1 word."))
            (t
             (message
              "The region has %d words." count))))))


;; Count the words in the entire document
(defun count-words-buffer ()
  "Count all the words in the buffer"
  (called-interactively)
  (count-words-region (point-min) (point-max) )
)

;; Window shifting. C-x-o lets us go forward a window (or several). This
;; one lets us go back one or more windows. From Glickstein.g
(defun other-window-backward (&optional n)
  "Select previous Nth window."
  (called-interactively "P")
  (other-window (- (prefix-numeric-value n))))

;; end window shifting.

;; Fine scroll without the mouse
(defun up-one () (called-interactively) (scroll-up 1))
(defun down-one () (called-interactively) (scroll-down 1))



(progn (message "Setting X11 windowing 1900x1030??")
       (setq default-frame-alist
	     (append default-frame-alist
		     '((top . 0) (left . 0)
;;		       (width . 1000) (height . 500)
		       (background-color . "#000000")
		       (foreground-color . "#f0f0f0")
		       (cursor-color	 . "red3")
;;		       (font . "-bitstream-Bitstream Vera Sans Mono-normal-normal-normal-*-*-90-*-*-m-0-iso10646-1")
		       (user-position t)
		       )))
       
;; Set the default font and frame size for the initial frame.
       (setq initial-frame-alist
	     '((top . 0) (left . 0)
;;	       (width . 750) (height . 500)
	       (background-color . "#04060a")
	       (foreground-color . "#fff0e0")
	       (cursor-color	. "red3")
	       (user-position t)
	       ))
       )

;; Begin completion mode.
(setq completion-styles '(partial-completion initials))
(setq completion-pcm-complete-word-inserts-delimiters t)


;ABBREVIATION SECTION
; abbreviation mode
(setq-default abbrev-mode t)
(if (file-exists-p "~/.abbrev")
    (read-abbrev-file "~/.abbrev"))
(setq save-abbrevs t)

;;dynamic abbreviation customizations
(setq dabbrev-case-replace nil)


;show more info in taskbar/icon than just "Emacs"
(setq-default frame-title-format (list "%65b %f"))
(setq-default icon-title-format (list "%b"))


;; ------------ Bookmarks -----------------------
;;-----------------------------------------------

;; Include common lisp stuff
(require 'cl)
(require 'bookmark)
(defvar af-current-bookmark nil)

(defun af-bookmark-make-name ()
  "makes a bookmark name from the buffer name and cursor position"
  (concat "\"" (buffer-name (current-buffer))
          "-" (number-to-string (point)) "\""))

(defun af-bookmark-toggle ()
  "remove a bookmark if it exists, create one if it doesnt exist"
  (called-interactively)
  (let ((bm-name (af-bookmark-make-name)))
    (progn (bookmark-set bm-name)
	   (setf af-current-bookmark bm-name)
	   (message "bookmark set"))))
(defun af-bookmark-cycle (i)
  "Cycle through bookmarks by i.  'i' should be 1 or -1"
  (if bookmark-alist
      (progn (unless af-current-bookmark
               (setf af-current-bookmark (first (first bookmark-alist))))
             (let ((cur-bm (assoc af-current-bookmark bookmark-alist)))
               (setf af-current-bookmark
                     (if cur-bm
                         (first (nth (mod (+ i (position cur-bm bookmark-alist))
                                          (length bookmark-alist))
                                     bookmark-alist))
                       (first (first bookmark-alist))))
               (bookmark-jump af-current-bookmark)
               ;; Update the position and name of the bookmark.  We
               ;; only need to do this when the bookmark has changed
               ;; position, but lets go ahead and do it all the time
               ;; anyway.
               (bookmark-set-position af-current-bookmark (point))
               (let ((new-name (af-bookmark-make-name)))
                 (bookmark-set-name af-current-bookmark new-name)
                 (setf af-current-bookmark new-name))))
    (message "There are no bookmarks set!")))
(defun af-bookmark-cycle-forward ()
  "find the next bookmark in the bookmark-alist"
  (called-interactively)
  (af-bookmark-cycle 1))
(defun af-bookmark-cycle-reverse ()
  "find the next bookmark in the bookmark-alist"
  (called-interactively)
  (af-bookmark-cycle -1))

(defun af-bookmark-clear-all()
  "clears all bookmarks"
  (called-interactively)
  (setf bookmark-alist nil))
;; --------------- End Bookmarks -----------------



;; --------------------- Tags --------------------
;;------------------------------------------------
(defun set-home-root-dir()
  (interactive)
  "set home directory"
;;  (called-interactively)
  (setq home-dir default-directory)
  (setenv "PRJ_HOME" home-dir)
  (setq ff-search-directories
        '("." "$PRJ_HOME/common" "$PRJ_HOME/common/includes"))
  (message  "Home directory set to: %s" home-dir)
)

(defun goto-home-dir()
  (interactive)
;;  (called-interactively)
  "Goto home directory"
  (cd home-dir)
  (message "Default directory switched to %s" home-dir)
)
(defun sync-tags ()
  (interactive)
  "Synchronize etags for the current project"
;; (called-interactively)
  (cd home-dir)
  (call-process-shell-command "rm TAGS")
  (call-process-shell-command "find . -type d -path './documentation/*'  -prune  -o -name \"*.[ch]\" -o -name \"*.cpp\" -o -name \"*.hpp\" | xargs etags -a")
  (visit-tags-table "TAGS")
  (message "TAGS file generated")
)


; --------------- End Tags ---------------------



;;-------------------  Keymaping ---------------------

(global-set-key "\C-x\p" 'other-window-backward)

(global-set-key "\M-p" 'down-one)
(global-set-key "\M-n" 'up-one)

(global-set-key "\M-g\M-l" 'text-scale-increase)
(global-set-key "\M-g\M-s" 'text-scale-decrease)

(global-set-key (kbd "C-c t")  'af-bookmark-toggle )
(global-set-key (kbd "C-c n")  'af-bookmark-cycle-forward )
(global-set-key (kbd "C-c p")  'af-bookmark-cycle-reverse )
(global-set-key (kbd "C-c c")  'af-bookmark-clear-all )

(global-set-key "\M-g\M-c" 'count-words-buffer)
(global-unset-key (kbd "M-SPC")) 
;(global-set-key (kbd "M-SPC") 'hippie-expand)
(global-set-key (kbd "C-z") 'undo)

(global-set-key "\M-g\M-d"  'goto-home-dir )
(global-set-key "\M-g\M-h"   'set-home-root-dir) 
(global-set-key "\M-g\M-t"  'sync-tags )
(global-set-key "\M-o"  'ff-find-other-file )


;;--------------- End Keymapping -------------

(setq stack-trace-on-error t)

;;; Emacs is not a package manager, and here we load its package manager!
(require 'package)
(dolist (source '(("marmalade" . "http://marmalade-repo.org/packages/")
                  ("elpa" . "http://elpa.org/packages")
                  ;; TODO: Maybe, use this after emacs24 is released
                  ;; (development versions of packages)
                  ("melpa" . "http://melpa.milkbox.net/packages/")
                  ))
  (add-to-list 'package-archives source t))
(package-initialize)
;;; end packages


;;; auto-complete
(require 'auto-complete-clang)
;(define-key c++-mode-map (kbd "M-SPC") 'ac-complete-clang)
(global-auto-complete-mode t)
(global-set-key (kbd "M-SPC") 'ac-complete-clang)

(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
              (ggtags-mode 1))))

;; Enable helm-gtags-mode
    (add-hook 'c-mode-hook 'helm-gtags-mode)
    (add-hook 'c++-mode-hook 'helm-gtags-mode)
    (add-hook 'asm-mode-hook 'helm-gtags-mode)

    ;; Set key bindings
    (eval-after-load "helm-gtags"
      '(progn
         (define-key helm-gtags-mode-map (kbd "M-t") 'helm-gtags-tag-find)
         (define-key helm-gtags-mode-map (kbd "M-r") 'helm-gtags-find-rtag)
         (define-key helm-gtags-mode-map (kbd "M-s") 'helm-gtags-find-symbol)
         (define-key helm-gtags-mode-map (kbd "M-g M-p") 'helm-gtags-parse-file)
         (define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
         (define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)
         (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)))

;; cmake settings
(add-to-list 'load-path "~/.emacs.d/lisp/cmake-font-lock")

(autoload 'cmake-font-lock-activate "cmake-font-lock" nil t)
(add-hook 'cmake-mode-hook 'cmake-font-lock-activate)

(require 'cmake-project)
