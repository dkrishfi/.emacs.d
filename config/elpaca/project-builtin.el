;;; project-builtin.el --- configuration for builtin project.el -*- lexical-binding: t; -*-
;;; must create manually

(with-eval-after-load 'project
  (setq project-list-file (expand-file-name "projects" dpk-state-dir)))
