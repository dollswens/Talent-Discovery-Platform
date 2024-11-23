;; Talent Discovery Platform

;; Constants
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-not-found (err u101))
(define-constant err-unauthorized (err u102))
(define-constant err-already-exists (err u103))

;; Data variables
(define-data-var next-profile-id uint u0)
(define-data-var next-job-id uint u0)

;; Data maps
(define-map profiles
  { profile-id: uint }
  {
    owner: principal,
    name: (string-utf8 50),
    skills: (list 20 (string-ascii 30))
  }
)

(define-map jobs
  { job-id: uint }
  {
    employer: principal,
    title: (string-utf8 100),
    description: (string-utf8 500),
    required-skills: (list 10 (string-ascii 30))
  }
)

;; Private functions
(define-private (is-owner)
  (is-eq tx-sender contract-owner)
)

