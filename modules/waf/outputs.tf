output "web_acl_arn" {
  value       = aws_wafv2_web_acl.alb-waf.arn
  description = "WAF Web ACL ARN"
}
