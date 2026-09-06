# Case Study: Remote Participants Cannot Hear Room Audio

## Scenario

A synthetic room joins a Teams meeting. The room can hear remote participants, but remote participants cannot hear the room.

## Investigation

1. Confirmed impact and preserved the current configuration.
2. Verified that the room microphone was not physically muted.
3. Opened the client device settings and found the laptop microphone selected instead of the room USB audio device.
4. Selected the documented room microphone and ran a local test.
5. Rejoined the synthetic test meeting and confirmed two-way audio.

## Fault domain

Application device selection—not network, account or room-amplification failure.

## Closure note

Remote participants could not hear the room because Teams was using the presenter laptop microphone rather than the room USB audio device. The approved room microphone was selected, local input was verified and two-way audio was confirmed. No account, policy or firmware change was made.

## Evidence boundary

This is a synthetic troubleshooting case designed to demonstrate reasoning and ticket quality. It is not presented as a real employer incident.
