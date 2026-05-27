# Molecule: SNS Fanout (Topic + Subscriptions + Policy)
module "topic" {
  source = "git::https://github.com/PlatformStackPulse/tf-atom-sns-topic-aws.git?ref=69c0da3e590cb2771ed79fede69948b2b83b6cfa"

  context = module.this.context
}

module "topic_policy" {
  source = "git::https://github.com/PlatformStackPulse/tf-atom-sns-topic-policy-aws.git?ref=fc531daf576462d3c04d6eb5c23d00d0fed171ba"

  count     = var.topic_policy != null ? 1 : 0
  context   = module.this.context
  topic_arn = module.topic.arn
  policy    = var.topic_policy

  depends_on = [module.topic]
}

module "subscriptions" {
  source = "git::https://github.com/PlatformStackPulse/tf-atom-sns-topic-subscription-aws.git?ref=7a83cfcf5c70e8826cda3c1dd6e97ce1c7bc4c63"

  for_each = { for idx, sub in var.subscriptions : idx => sub }

  context   = module.this.context
  topic_arn = module.topic.arn
  protocol  = each.value.protocol
  endpoint  = each.value.endpoint

  depends_on = [module.topic]
}
