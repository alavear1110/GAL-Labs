# ExpPay Baseline

Opening:
Employees submit expenses in an existing employee portal. Managers approve them and Finance handles reimbursement.

Controlled rules:
- corporate card <= $25 auto-approved
- $26-$100 manager approval
- $101+ manager + next-level manager
- out-of-pocket always routes to manager; $101+ also next-level
- receipts required $26+
- categories mirror QuickBooks expense types
- corporate-card payment is vendor-agnostic
- out-of-pocket reimbursement occurs through next payroll after approval
- rejected expenses may be revised and resubmitted
- expenses must be submitted within 60 days

Intentional unknowns:
- missing receipt behavior
- multi-level sequencing
- resubmission routing mechanics
- draft-save behavior
- notification requirements
- reporting requirements
- payment execution/system boundary
