package com.onesignal;

import com.onesignal.OSNotificationReceivedResult;
import com.onesignal.OneSignal.OSNotificationExtender;

public class NotificationExtenderExample implements OSNotificationExtender {
    @Override
    public OSNotificationReceivedResult extend(OSNotificationReceivedResult receivedResult) {
        // Customize your notification here
        return receivedResult;
    }
}
