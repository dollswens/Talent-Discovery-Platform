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

;; Public functions
(define-public (create-profile (name (string-utf8 50)))
  (let (
    (profile-id (var-get next-profile-id))
  )
    (begin
      (map-set profiles
        { profile-id: profile-id }
        {
          owner: tx-sender,
          name: name,
          skills: (list)
        }
      )
      (var-set next-profile-id (+ profile-id u1))
      (ok profile-id)
    )
  )
)

(define-public (add-skill (profile-id uint) (skill (string-ascii 30)))
  (let (
    (profile (unwrap! (get-profile profile-id) (err err-not-found)))
  )
    (begin
      (asserts! (is-eq (get owner profile) tx-sender) (err err-unauthorized))
      (ok (map-set profiles
        { profile-id: profile-id }
        (merge profile
          { skills: (unwrap! (as-max-len? (append (get skills profile) skill) u20) (err err-unauthorized)) }
        )
      ))
    )
  )
)

(define-public (create-job (title (string-utf8 100)) (description (string-utf8 500)))
  (let (
    (job-id (var-get next-job-id))
  )
    (begin
      (map-set jobs
        { job-id: job-id }
        {
          employer: tx-sender,
          title: title,
          description: description,
          required-skills: (list)
        }
      )
      (var-set next-job-id (+ job-id u1))
      (ok job-id)
    )
  )
)

(define-public (add-required-skill (job-id uint) (skill (string-ascii 30)))
  (let (
    (job (unwrap! (get-job job-id) (err err-not-found)))
  )
    (begin
      (asserts! (is-eq (get employer job) tx-sender) (err err-unauthorized))
      (ok (map-set jobs
        { job-id: job-id }
        (merge job
          { required-skills: (unwrap! (as-max-len? (append (get required-skills job) skill) u10) (err err-unauthorized)) }
        )
      ))
    )
  )
)

;; Read-only functions
(define-read-only (get-profile (profile-id uint))
  (map-get? profiles { profile-id: profile-id })
)

(define-read-only (get-job (job-id uint))
  (map-get? jobs { job-id: job-id })
)
