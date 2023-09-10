![MIUI Monet Project](https://github.com/MIUI-Monet-Project/.github/blob/main/profile/banner.jpg?raw=true)
<h1 align="center">MIUI Monet Project</h1>
<div align="center">
  <strong>MIUI Monet Project brings wallpaper-based dynamic theme to MIUI system apps on Android 12+</strong>
</div>
<br/><br/>
<div align="center">
  <!-- Version -->
  <a href="https://github.com/MIUI-Monet-Project/Module/releases"><img src="https://img.shields.io/github/v/release/miui-monet-project/module?color=green&include_prereleases&logo=magisk&logoColor=white&style=for-the-badge"
                                                                       alt="Latest Version" /></a>
  <!-- Last Updated -->
<!--  <img src="https://img.shields.io/github/release-date/miui-monet-project/module?style=for-the-badge" alt="_time_stamp_" /> -->
  <!-- Min Magisk -->
  <img src="https://img.shields.io/badge/Min Magisk-20.4-red.svg?longCache=true&style=for-the-badge"
      alt="Min Magisk v20.4" />
</div>


<div align="center">
   <a href="https://telegra.ph/Whats-Currently-Themed-11-06" ><img src="https://img.shields.io/badge/Themed App-List-blue?longCache=true&style=for-the-badge" alt="Themed Apps List" /></a>
   <a href="https://t.me/MIUIMonetUpdate" ><img src="https://img.shields.io/badge/telegram-channel-blue?longCache=true&style=for-the-badge&logo=telegram&logoColor=white" alt="Telegram Channel" /></a>
   <a href="https://t.me/MIUIMonet" ><img src="https://img.shields.io/badge/telegram-discuss-blue?longCache=true&style=for-the-badge&logo=telegram&logoColor=white" alt="Telegram Channel" /></a>
</div>

<br/><br/><br/><br/>

## Requirements

- **Magisk 20.4 and higher**
- **Knowledge to install Magisk Module**
- **Minimum ROM Version MIUI 13 with Android 12** with ROM **release date after January 2022**
- **System UI Plugin version 13.1.x.xx** and higher

<br/><br/>

## Changelog

Please see [CHANGELOG](CHANGELOG.md) for more information what has changed recently.

<br/><br/>

## What's Currently Themed?

Please see [Themed apps](APPS.md) list for more information.

<br/><br/>

## Notes

- With the latest update, **we only support System UI Plugin version 13.1.x.xx and higher**, please check the notes on the group before reporting.
- **Restart SystemUI is mandatory only for changing the Control Center colour** after changing the theme or wallpaper.
- **No restart is needed for changing the rest of the app colour** after changing the theme or wallpaper. **Simply “Force Stop” the app**.
- To switch between default and themed icons, reflash the module and select a version.
- If possible, **please use the default theme or MIUI Monet Project companion theme only because some themes can overwrite the Module** and some heavily modified themes **can crash your phone.**
- **We won’t support custom icons & custom Control Center layouts from custom MIUI ROMs / modules**.

<br/><br/>

## Known Issues

- We won’t guarantee support for Port ROMs since there are some reports that Port ROMs can’t use our modules.
- Security app may be a little janky with the background because Xiaomi used MP4 for the animation instead of XML.
- The accent theme not changing sometimes when using MiWallpaper.
  - Solution: Use static wallpaper from Gallery

<br/><br/>

## Troubleshooting

- **The module is not working.**
  \- Make sure Core-only mode is deactivated in Magisk settings
  \- Don't put any themed apps on denylist
- **Bootloop.**
  \- Make sure that you are not using Ported/Modded ROMs.
  \- If not, probably there's an overlay conflict from the substratum or device.

<br/><br/>

## Experimental UI Options

MIUI Monet Project has new experimental UI options that enable new control center background but it's quite unstable and might not work well with certain versions of the SystemUI Plugin. Below are steps to apply the experimental UI:

- Apply the status bar section of the MIUI Monet theme on MIUI Themes app
- Restart SystemUI after switching to light/dark mode or changing the wallpaper
