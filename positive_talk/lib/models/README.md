# Models Package

This package contains all domain models for the Flutter application.

## Available Models

### User Model (`user_model.dart`)
Represents a user in the system with profile information and token balance.

**Fields:**
- `id`: Unique user identifier
- `name`: User's display name
- `phoneNumber`: Contact phone number
- `profileImage`: Profile picture URL
- `referralCode`: User's referral code
- `tokenBalance`: Current token balance
- `createdAt`: Account creation timestamp

### Vendor Model (`vendor_model.dart`)
Represents a service provider/vendor in the system.

**Fields:**
- `id`: Unique vendor identifier
- `name`: Vendor's display name
- `gender`: Vendor's gender
- `age`: Vendor's age
- `profileImage`: Profile picture URL
- `rating`: Average rating (0.0-5.0)
- `totalReviews`: Total number of reviews
- `description`: Vendor description/bio
- `experienceHours`: Total experience in hours
- `isOnline`: Current online status
- `verified`: Verification status
- `ratePerMinute`: Token cost per minute

### Message Model (`message_model.dart`)
Represents a chat message between users and vendors.

**Fields:**
- `id`: Unique message identifier
- `senderId`: ID of message sender
- `receiverId`: ID of message receiver
- `text`: Message content
- `timestamp`: Message creation time
- `isRead`: Read status

### Call Session Model (`call_session_model.dart`)
Represents a call session between user and vendor.

**Fields:**
- `id`: Unique session identifier
- `userId`: User who initiated the call
- `vendorId`: Vendor who received the call
- `startTime`: Call start time
- `endTime`: Call end time
- `durationSeconds`: Call duration in seconds
- `tokensSpent`: Tokens consumed during call
- `callStatus`: Current call status (waiting, ongoing, completed, cancelled, failed)

### Transaction Model (`transaction_model.dart`)
Represents financial transactions in the system.

**Fields:**
- `id`: Unique transaction identifier
- `userId`: User who performed the transaction
- `type`: Transaction type (credit/debit)
- `tokens`: Number of tokens involved
- `amount`: Monetary value in USD
- `description`: Transaction description
- `createdAt`: Transaction timestamp

### Referral Model (`referral_model.dart`)
Represents referral relationships between users.

**Fields:**
- `id`: Unique referral identifier
- `referrerUserId`: User who made the referral
- `referredUserId`: User who was referred
- `rewardTokens`: Tokens awarded for referral
- `status`: Referral status (pending, completed, expired)
- `createdAt`: Referral creation timestamp

### Usage Record Model (`usage_record_model.dart`)
Represents usage history for analytics.

**Fields:**
- `id`: Unique usage record identifier
- `userId`: User who consumed the service
- `vendorId`: Vendor who provided the service
- `vendorName`: Display name of vendor
- `type`: Usage type (call/chat)
- `duration`: Service duration
- `tokensUsed`: Tokens consumed
- `date`: Usage timestamp

## Features

- **Null Safety**: All models use nullable types appropriately
- **JSON Serialization**: All models include `fromJson()` and `toJson()` methods
- **Strong Typing**: All fields have explicit types
- **Immutability**: All fields are final
- **Validation**: Proper type casting and error handling

## Usage

```dart
import 'models/user_model.dart';
import 'models/vendor_model.dart';
import 'models/message_model.dart';
// etc.
```

All models are ready for integration with services and UI components.
