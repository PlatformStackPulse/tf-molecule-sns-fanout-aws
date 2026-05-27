variable "topic_policy" {
  description = "JSON IAM policy for the SNS topic (optional)"
  type        = string
  default     = null
}

variable "subscriptions" {
  description = "List of subscriptions to create"
  type = list(object({
    protocol = string
    endpoint = string
  }))
  default = []
}
