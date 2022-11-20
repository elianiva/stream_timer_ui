# stream_timer_ui

A simple Flutter UI clone showing a countdown timer utilising the Stream class. My submission for one of [WRI](https://github.com/wrideveloper) assignments.

The UI is taken from [Angelica Dovnar | Daily UI 14 - Countdown Timer](https://dribbble.com/shots/7110551-Daily-UI-14-Countdown-Timer) on Dribbble.

## How it works

There's a `CountdownBloc`, which is basically a stream that emits the current difference and the next difference every second.
The reason why we need the next difference is because we need to know one second ahead due to how the ticking animation works. It basically scrolls to the next 'second' then replace the number and reset the animation repeatedly. For example, current time diff is 20, the animation will scroll to 19, but 19 is still on the next time diff. This knowledge is used to determine whether or not to animate the clock digit.

The animation is done using `AnimatedBuilder` and `Transform.translate` widget. To get the scrolling digit effect, the entire clock display is wrapped in a `Wrap` widget to hide the overflowed widget just like how `overflow: hidden` in CSS.

[brestnichki/humanbeans-clock](https://github.com/brestnichki/humanbeans-clock) was used as a reference when building the animation logic.

## Preview

https://user-images.githubusercontent.com/51877647/202879617-d41f8a9f-7703-48a0-a9de-ca31da8db65d.mp4

## Development

It's just a Flutter project. You can just press F5 on Android Studio or VSCode and be done with your day.
Although, if you don't like those options, you can always run `flutter run` in your CLI, but you won't get the niceties that come with the debugger.
