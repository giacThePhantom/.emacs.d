(setq inhibit-startup-message t)
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(custom-set-variables
 '(custom-safe-themes
   '("83e0376b5df8d6a3fbdfffb9fb0e8cf41a11799d9471293a810deb7586c131e6" "6b5c518d1c250a8ce17463b7e435e9e20faa84f3f7defba8b579d4f5925f60c1" default))
 '(package-selected-packages
   '(dashboard all-the-icons page-break-lines magit projectile undo-fu evil gruvbox-theme)))
(custom-set-faces
 )
(load-theme 'gruvbox-dark-soft t)

;; Enable Evil
(require 'evil)
(evil-mode 1)
(define-key evil-normal-state-map "\C-r" 'undo-fu-only-redo)

;; Orgmode stuff
(setq org-support-shift-select t)
(setq browse-url-browser-function 'eww-browse-url)
(setq ring-bell-function 'ignore)

;; Set projects
(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(require 'magit)
(with-eval-after-load 'magit
  (setq magit-repository-directories
        '(;; Directory containing project root directories
          ("~/Universita/" . 1))))

(with-eval-after-load 'projectile
  (when (require 'magit nil t)
    (mapc #'projectile-add-known-project
          (mapcar #'file-name-as-directory (magit-list-repos)))
    ;; Optionally write to persistent `projectile-known-projects-file'
    (projectile-save-known-projects)))

;; Dashboard
(require 'all-the-icons)
(require 'dashboard)
(dashboard-setup-startup-hook)
(setq dashboard-startup-banner "~/.emacs.d/themes/emacs.png")
(setq dashboard-center-content t)

(setq dashboard-banner-logo-title nil)
(setq dashboard-set-init-info nil)
(setq dashboard-set-footer nil)
(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)
(setq dashboard-items '((projects . 5)
			(agenda . 5)
			(recents . 5)
			(registers . 5)))
(setq dashboard-set-navigator t)
(setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
;; Dired toggle hidden file
(setq my-dired-ls-switches "-alh --ignore=.* --ignore=\\#* --ignore=*~")
(setq my-dired-switch 1)
(add-hook 'dired-mode-hook
           (lambda ()
             "Set the right mode for new dired buffers."
             (when (= my-dired-switch 1)
               (dired-sort-other my-dired-ls-switches))))

(add-hook 'dired-mode-hook
          (lambda ()
            (define-key dired-mode-map (kbd "M-o")
               (lambda ()
                 "Toggle between hide and show."
                 (interactive)
                 (setq my-dired-switch (- my-dired-switch))
                 (if (= my-dired-switch 1)
                     (dired-sort-other my-dired-ls-switches)
                   (dired-sort-other "-alh"))))))
