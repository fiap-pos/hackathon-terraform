locals {
  relatorios_queue_name = "relatorios"
}


# ---- Producao Queue ----

# Create Producao SQS dlq Queue
resource "aws_sqs_queue" "ponto-dlq-queue" {
  name = "${local.relatorios_queue_name}-dlq"
  tags = {
    Name = "${local.relatorios_queue_name}-dlq"
    application = var.ponto_application_tag_name
  }
}

# Create Producao SQS Queue
resource "aws_sqs_queue" "ponto-queue" {
  name = local.relatorios_queue_name
  tags = {
    Name = local.relatorios_queue_name
    application = var.ponto_application_tag_name
  }
}

# Create Redrive Producao Queue policy
resource "aws_sqs_queue_redrive_allow_policy" "ponto-queue-redrive-policy" {
  queue_url = aws_sqs_queue.ponto-queue.id

  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue",
    sourceQueueArns   = [aws_sqs_queue.ponto-dlq-queue.arn]
  })
}

