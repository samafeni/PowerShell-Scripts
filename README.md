# Zero Trust Autopilot Deployment Framework

![Status](https://img.shields.io/badge/Status-Active-blue)
![Platform](https://img.shields.io/badge/Platform-Microsoft%20365-blue)
![Tool](https://img.shields.io/badge/Tool-Microsoft%20Intune-informational)

## Overview

A structured framework for deploying Windows devices using Windows Autopilot
with Zero Trust security controls enforced through Microsoft Intune.

This project documents the deployment flow, PowerShell validation scripts,
and configuration decisions for Windows device onboarding.

## Architecture

```text
Vendor ships device
  → Device pre-registered via hardware hash
  → User powers on → OOBE → signs in with M365 credentials
  → Autopilot profile applies → Entra ID Join
  → Intune enrolment → Compliance policy evaluated
  → Conditional Access enforced → M365 access granted
  → Required apps deploy → Device fully configured