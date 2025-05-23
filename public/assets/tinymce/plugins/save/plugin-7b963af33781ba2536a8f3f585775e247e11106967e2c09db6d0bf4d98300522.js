/**
 * Copyright (c) Tiny Technologies, Inc. All rights reserved.
 * Licensed under the LGPL or a commercial license.
 * For LGPL see License.txt in the project root for license information.
 * For commercial licenses see https://www.tiny.cloud/
 *
 * Version: 5.8.2 (2021-06-23)
 */
!function(){"use strict";var e=tinymce.util.Tools.resolve("tinymce.PluginManager"),o=tinymce.util.Tools.resolve("tinymce.dom.DOMUtils"),a=tinymce.util.Tools.resolve("tinymce.util.Tools"),i=function(e){return e.getParam("save_enablewhendirty",!0)},c=function(e,n){e.notificationManager.open({text:n,type:"error"})},t=function(t){t.addCommand("mceSave",function(){!function(e){var n=o.DOM.getParent(e.id,"form");if(!i(e)||e.isDirty()){if(e.save(),e.getParam("save_onsavecallback"))return e.execCallback("save_onsavecallback",e),e.nodeChanged();n?(e.setDirty(!1),n.onsubmit&&!n.onsubmit()||("function"==typeof n.submit?n.submit():c(e,"Error: Form submit field collision.")),e.nodeChanged()):c(e,"Error: No form element found.")}}(t)}),t.addCommand("mceCancel",function(){var e,n;e=t,n=a.trim(e.startContent),e.getParam("save_oncancelcallback")?e.execCallback("save_oncancelcallback",e):e.resetContent(n)})},r=function(t){return function(e){var n=function(){e.setDisabled(i(t)&&!t.isDirty())};return t.on("NodeChange dirty",n),function(){return t.off("NodeChange dirty",n)}}};e.add("save",function(e){var n;(n=e).ui.registry.addButton("save",{icon:"save",tooltip:"Save",disabled:!0,onAction:function(){return n.execCommand("mceSave")},onSetup:r(n)}),n.ui.registry.addButton("cancel",{icon:"cancel",tooltip:"Cancel",disabled:!0,onAction:function(){return n.execCommand("mceCancel")},onSetup:r(n)}),n.addShortcut("Meta+S","","mceSave"),t(e)})}();
