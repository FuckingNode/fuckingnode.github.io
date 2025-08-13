# System notifications

By default, `clean`, `migrate`, and `kickstart`, which are considered features that _can_ take a long time, will send a system UI notification if they _do_ take long. Unless you're on DND it should sound - which is the point of it. They're sent so you can safely move away from the terminal and know when we're done, so you can get back to whatever's next as soon as possible.

These notifications are fired if the running task took more than 30 seconds to complete. This threshold can be disabled, so they're shown even if it takes 1 second. In future versions you'll be able to customize the threshold.

Notifications are enabled by default, but can be disabled if you don't like them.

!!! warning Support for Linux
    On Linux, it's assumed that `notify-send` is installed. If not, notifications simply won't be sent, without a warning.
