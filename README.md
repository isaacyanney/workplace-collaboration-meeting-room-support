# Workplace Collaboration & Meeting-Room Support

A reproducible practice framework for first-line meeting-room support. It covers safe fault isolation across power, cabling, displays, audio, cameras, microphones, USB/docking, networks, room accounts and Teams/Zoom services.

## Evidence boundary

This is an independent documentation and automation project using synthetic rooms, devices and incidents. It does not claim ownership of a production room fleet, access to an employer environment, paid client work or vendor certification.

## Recruiter review path

1. Read the [first-response runbook](docs/first-response-runbook.md).
2. Review the [Teams and Zoom workflow](docs/teams-zoom-workflow.md).
3. Inspect the [no-room-audio case study](docs/case-study-no-room-audio.md).
4. Review the [synthetic room inventory](data/room-inventory.csv).
5. Inspect the [inventory validator](scripts/Test-RoomInventory.ps1), [tests](tests/Test-RoomInventory.Tests.ps1) and [sample validation result](sample-output/inventory-validation.example.json).
6. Review the [example ticket](sample-output/incident-ticket.example.md) and [escalation checklist](docs/escalation-checklist.md).

## Capabilities demonstrated

- structured first response and impact assessment
- signal-path isolation for display, audio and USB devices
- Teams and Zoom client/service checks
- room-account, calendar and network boundaries
- user communication, ticket evidence and escalation
- synthetic asset documentation and validation
- safe PowerShell automation with no device changes

## Validate the synthetic inventory

```powershell
.\scripts\Test-RoomInventory.ps1 `
  -InventoryPath .\data\room-inventory.csv `
  -OutputPath .\output\inventory-validation.json
```

The script reads inventory data and reports validation findings. It does not connect to devices, rooms, calendars, networks or cloud services.

## Repository structure

```text
data/room-inventory.csv
docs/first-response-runbook.md
docs/teams-zoom-workflow.md
docs/case-study-no-room-audio.md
docs/escalation-checklist.md
scripts/Test-RoomInventory.ps1
tests/Test-RoomInventory.Tests.ps1
sample-output/inventory-validation.example.json
sample-output/incident-ticket.example.md
.github/workflows/validation.yml
```

## Safety principles

- Never collect passwords, MFA codes or meeting content.
- Confirm authorisation before changing room accounts, policies or firmware.
- Record cable and configuration state before changing it.
- Use known-good components to isolate faults.
- Escalate security, multi-room and infrastructure issues with evidence.

## Author

**Isaac Lovelace Yanney** — IT Support & Technical Operations  
[GitHub](https://github.com/isaacyanney) · [LinkedIn](https://www.linkedin.com/in/isaac-lovelace-yanney/)
