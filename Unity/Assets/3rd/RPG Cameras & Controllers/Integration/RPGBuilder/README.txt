Integration with RPGBuilder v2.0 by Blink Studios 
https://assetstore.unity.com/packages/tools/game-toolkits/rpg-builder-177657

0) Import my asset from the Package Manager (Window > Package Manager > My Assets)
1) Import Unity's new Input System here as well but from the Unity Registry
2) Activate the new input system by going to Edit > Project Settings > Player > Active Input Handling and selecting "Both" from the drop-down list
3) Import the files of the provided integration unitypackage (Integration > RPGBuilder) by double-clicking it and pressing the "Import" button
4) Assign the provided prefab(s) inside the RPG Builder editor at the top (BLINK > RPG Builder) under Character > Races > Genders
5) Uncheck "Dynamic Animator" and Save
6) Done

-- optional --
Mounts) You need to assign an animator override controller to the mount effect (under "Animator Controller") which has the used Integrated Animator (ARPG or MMO) as basis. See folder Integration > RPGBuilder > Animator Controller > Overrides for examples for bear mount animator overrides

Since it is hard for me to test every single RPGBuilder feature, please report any integration bugs you find via https://johnstairs.com/rcc/#contact or write me in the Blink Discord - thanks!

Best regards,
John