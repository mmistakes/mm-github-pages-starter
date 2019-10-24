---
title: Using `@Parcelize` in Kotlin Multiplatform 
categories: industry
tags: 
  - kotlin
  - android
  - multiplatform
toc: true
toc_sticky: true
excerpt: Using Platform-Specific Declarations to unlock `@Parcelize` in Kotlin Multiplatform Projects
header:
  overlay_color: "#333"
  actions:
    - label: "See the source"
      url: "https://github.com/ankushg/MultiplatformParcelize"
---

Corresponding code for this blog post [is available on GitHub](https://github.com/ankushg/MultiplatformParcelize)
{: .notice--info}

# Background on `Parcel`s

The Android OS uses [`Parcel`s ](https://developer.android.com/reference/android/os/Parcel)as a high-performance method to communicate data. The Android-only `Parcelable` interface is used to denote classes that can easily be serialized to/from a `Parcel`.

They're most frequently used with `Bundle` objects to communicate across activities and intents, and to store state across configuration changes. 

As a result, most Android developers should be familiar with the concept of `Parcelable` classes.

# Using the `@Parcelize` Android Extensions Plugin
Hand-writing `Parcelable` implementations can be quite a pain. Thankfully, several tools exist to automagically generate the requisite code for you. 

One such tool is the `@Parcelize` Kotlin compiler plugin. `@Parcelize` is included with Kotlin and can automatically [generate Parcelable implementations](https://kotlinlang.org/docs/tutorials/android-plugin.html#parcelable-implementations-generator) for you! The following section is adapted from their documentation.

In the base case, the process is pleasantly simple:

```kotlin
import android.os.Parcelable
import kotlinx.android.parcel.Parcelize

@Parcelize
data class User(
  val userId: long,
  val userName: String
): Parcelable
```

## Advanced `Parcel`ing Logic

The `@Parcelize` Android Extensions plugin has built-in support for several types, but also allows you to specify a custom parceling logic!

If your class requires advanced serialization logic, you can write it inside a companion class:

```kotlin
@Parcelize
data class User(
  val userId: long,
  val userName: String
): Parcelable {
  private companion object : Parceler<User> {
    override fun User.write(parcel: Parcel, flags: Int) {
      TODO("my custom write implementation")
    }

    override fun create(parcel: Parcel): User {
      TODO("my custom read implementation")
    }
  }
}
```

If you are working with an unsupported type that you can't personally modify the code for, you can supply an external `Parceler` implementation for it. For example, if we used the `java.util.UUID` class instead of a `Long` to create a unique identifier for our `User`…

```kotlin
import java.util.UUID

import kotlinx.android.parcel.Parceler

object UUIDParceler : Parceler<UUID> {
  override fun create(parcel: Parcel): UUID {
    val mostSigBits = parcel.readLong()
    val leastSigBits = parcel.readLong()
    return UUID(mostSigBigs, leastSigBits)
  }

  override fun UUID.write(parcel: Parcel, flags: Int) {
    parcel.writeLong(mostSigBits)
    parcel.writeLong(leastSigBits)
  }
}
```

External `Parceler`s can be applied using either the `@TypeParceler` or `@WriteWith` annotation:

```kotlin
import java.util.UUID

import kotlinx.android.parcel.*

// Class-local parceler
@Parcelize
@TypeParceler<UUID, UUIDParceler>()
data class User(
  val id: UUID
)

// Property-local parceler
@Parcelize
class User(
  @TypeParceler<UUID, UUIDParceler>()
  val id: UUID
)

// Type-local parceler
@Parcelize
class User(
  val id: @WriteWith<UUIDParceler>() UUID
)
```

If you take a peek at the [source code for the Parcelize Android Extension](https://github.com/JetBrains/kotlin/tree/master/plugins/android-extensions/android-extensions-runtime/src/kotlinx/android/parcel), you will find a few other annotations such as `@IgnoredOnParcel` and `@RawValue`, however their usage isn't officially documented so I won't get into them here 😉  

# Enter Kotlin Multiplatform

Generating `Parcelable` implementations using `@Parcelize` works great when you're operating in the Android world. However, if you are working in a Kotlin Multiplatform Project, you will find that things aren't quite so simple!

If you try to paste those earlier code samples into the common sourceset in a [Kotlin Multiplatform Project](https://kotlinlang.org/docs/reference/multiplatform.html), you'll quickly find that you can't import `Parcelable` or `@Parcelize`, `@TypeParceler` or `@WriteWith`!

If you take a step back however, this makes sense. The concept of `Parcelable` objects is Android-specific. `Parcel`-related classes simply don't exist in non-Android environments. 

But what do we do if we use a Kotlin Multiplatform library, and want to store some of those classes in an Android `Bundle`?

We _could_ use the concepts from the Advanced Parceling Logic section to declare external `Parceler`s and sprinkle  `@TypeParceler` or `@WriteWith` all over our Android codebase as I described earlier. 

Or, we can take advantage of Kotlin Multiplatform's[ powerful platform-specific declarations](https://kotlinlang.org/docs/reference/platform-specific-declarations.html) to make things work for us!

## Declaring `expect` Definitions

In order to use these annotations and the `Parcelable` interface in common code, we must make the common code aware that they exist.

First, let's start with the `Parcelable` interface:

```kotlin
package com.example.parcel

// Common Code
expect interface Parcelable
```

By declaring an empty expected interface in our common sourceset, we will be able to write classes that implement `com.example.parcel.Parcelable`.

Let's continue by defining the expected `@Parcelize` annotation:

```kotlin
package com.example.parcel

// Common Code
@UseExperimental(ExperimentalMultiplatform::class)
@OptionalExpectation
@Target(AnnotationTarget.CLASS)
@Retention(AnnotationRetention.BINARY)
expect annotation class Parcelize()
```

If you're extra-observant, you might have noticed something different here. We're using the [`@OptionalExpectation`](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/-optional-expectation/index.html) annotation, after opting-in to the experimental multiplatform feature.

`@OptionalExpectation` can be added to `annotation class`es to denote that the class isn't _required_ to have an `actual` counterpart on every platform. If we use the annotation and compile for a platform where we don't implement the annotation at all, the Kotlin compiler just pretends the annotation never existed!

> If an optional annotation has no corresponding actual class on a platform, the annotation entries where it's used are simply erased when compiling code on that platform.

This is the same mechanism that Kotlin Multiplatform uses to allow us to use built-in annotations like `@JvmName` and `@JsName` in Common code. 

Now that we've declared our `expect`ed classes, we have to `actual`ly define them on our platforms.

## Android-Land

### Building a Real Android Library

Most default Kotlin Multiplatform templates write code for Android using the `jvm` target. In many cases, this is fine. However, in order to use the `@Parcelize` plugin, we will need to create an actual Android Library using the `com.android.library` Gradle plugin.
{: .notice--warning}

[Take a peek at this commit on Github to see the full details](https://github.com/ankushg/MultiplatformParcelize/commit/b05d5b8249dd9761f0d55da9fe1dfb787b689cd4), but below are some of the changes you may need to make:

Adding the `com.android.library` and `kotlin-android-extensions` plugins:

```gradle
plugins {
    id 'com.android.library'
    id 'org.jetbrains.kotlin.multiplatform'
    id 'kotlin-android-extensions'
}
```

Adding an explicit `android()` target platform:

```gradle
kotlin {
    jvm()
    android()
    js {
        nodejs {
        }
    }

    // Configuration...
}
```

Adding an `android { }` block where we point to our sourceSets to the code for the `android()` target platform and enable the `@Parcelize` plugin:

```gradle
android {
    compileSdkVersion 28

    androidExtensions {
        experimental = true
    }

    defaultConfig {
        minSdkVersion 21
        testInstrumentationRunner "androidx.test.runner.AndroidJUnitRunner"
    }

    // Android Gradle Plugin expects sources to be in main, test, and androidTest
    // In order to keep our code structure consistent across platforms, we redefine
    // the sourceset directories here.
    sourceSets {
        // Main code is in androidMain
        main {
            manifest.srcFile 'src/androidMain/AndroidManifest.xml'
            java.srcDirs = ['src/androidMain/kotlin']
            res.srcDirs = ['src/androidMain/res']
        }

        // Unit test code is in androidTest (to parallel jvmTest, jsTest)
        test {
            java.srcDirs = ['src/androidTest/kotlin']
            res.srcDirs = ['src/androidTest/res']
        }

        // Android instrumentation test code is in androidInstrumentationTests
        androidTest {
            java.srcDirs = ['src/androidInstrumentationTest/kotlin']
            res.srcDirs = ['src/androidInstrumentationTest/res']
        }
    }
}
```

### The Magic of `actual typealias`es

A powerful feature of Kotlin Multiplatform is that platform-specific declarations can be simple `typealias`es to existing classes.

This is great, because it allows us to point our `expect`ed interface and annotation to very real classes that we already have on Android!

```kotlin
package com.example.parcel

actual typealias Parcelable = android.os.Parcelable
actual typealias Parcelize = kotlinx.android.parcel.Parcelize
```

## Every Other Platform

Thanks to the magic of the `@OptionalExpectation` annotation, we don't need to declare `actual` implementations for `@Parcelize` on non-Android platforms.

Unfortunately,  `@OptionalExpectation` only supports `annotation class`es. As a result, we _do_ have to write an empty `actual interface Parcelable` for every platform:

```kotlin
package com.example.parcel

actual interface Parcelable
```

Once we do this, we should be ready to roll!

## Putting It All Together

We can now use our custom `Parcelable` and `@Parcelize` definitions in Common Code!

```kotlin
import com.example.parcel.*

@Parcelize
data class User(
  val userId: long,
  val userName: String
): Parcelable
```

In Android, we can take advantage of the class we defined in common code, and store it in a `Bundle`!

```kotlin
val user = User(1, "Android User")
val bundle = Bundle().apply {
    putParcelable(
        USER_BUNDLE_KEY,
        user
    )
}

val unparceled: User? = bundle.getParcelable(USER_BUNDLE_KEY)

assertEquals(user, unparceled) // Nice!
```

You might notice that we didn't go into the details needed for `@TypeParceler` or `@WriteWith`. 

While these classes certainly _can_ be added to a Kotlin Multiplatform project in this manner, doing so requires creating `expect`/`actual` declarations for many more classes (for example, `Parcel`, `kotlinx.android.parcel.Parceler`), and their methods. 

For this reason, these extra steps (if you need them) are left as an exercise for the reader 😉  

# Wrapping Up

The same principles used here can apply to many other platform-specific annotations, classes, and interfaces.

If you've got other cool ideas for how this technique could be used, [drop me a tweet](https://twitter.com/ankushg)!
