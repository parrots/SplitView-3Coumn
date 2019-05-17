# 3-column UISplitViewController Example Project

This is a quick sample project demonstrating the ability to nest splitview controllers. This was prototype was commissioned for [Slopes](https://getslopes.com) and was written by [Joe Cieplinski](https://twitter.com/jcieplinski/) (I was too heads-down on other features for two days of UIKit hair-pulling, lol).

The main trick of this is that a splitview can't be inside a navigationcontroller in compact mode / iPhone. As a result, additional logic is needed when going regular -> compact to remove the nested splitview and add those viewcontrollers to the master splitview's detail side, and visa versa to split back out to multiple splitviews.

This also differs from an implimentation similar to Mail.app that the top-level splitview's master side never goes down more then one level, it forces all of that into the secondary splitview (a requirement of how Slopes needed to display things). In theory come Marzipan one can change the top-level splitview to `.allVisible` when the target is macOS to get a full three-column layout at once (or, could do this based on screen size for the iPad 12").

See example of it in action: [example video](https://github.com/parrots/SplitView-3Coumn/raw/master/Example.MOV)