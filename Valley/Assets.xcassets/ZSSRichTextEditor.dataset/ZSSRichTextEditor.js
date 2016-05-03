/*!
 *
 * ZSSRichTextEditor v0.5.2
 * http://www.zedsaid.com
 *
 * Copyright 2014 Zed Said Studio LLC
 *
 */

var zss_editor = {};

// If we are using iOS or desktop
zss_editor.isUsingiOS = true;

// If the user is draging
zss_editor.isDragging = false;

// The current selection
zss_editor.currentSelection;

// The current editing image
zss_editor.currentEditingImage;

// The current editing link
zss_editor.currentEditingLink;

// The objects that are enabled
zss_editor.enabledItems = {};

// Height of content window, will be set by viewController


// Sets to true when extra footer gap shows and requires to hide
zss_editor.updateScrollOffset = false;

/**
 * The initializer function that must be called onLoad
 */

var $zss_editor_content,$zss_editor_footer;

zss_editor.getContentHeight = function(){
    if(!zss_editor.contentHeight){
        zss_editor.contentHeight = $(window).innerHeight();
    }
    return zss_editor.contentHeight;
}

function removeNullTextNode(that){// 绉婚櫎绌烘枃鏈妭鐐�
    var child = that.childNodes ;
    [].slice.call(child).forEach(function(ele){
                                 if (/^\s*$/.test(ele.nodeValue)){
                                 ele.parentNode.removeChild(ele)
                                 }
                                 })
}

zss_editor.init = function(){
    $zss_editor_content = $('#zss_editor_content'),$zss_editor_footer  = $('#zss_editor_footer');
    $zss_editor_content.on('touchend', function(e){
                           setTimeout(function(){
                                      zss_editor.enabledEditingItems(e);
                                      },0);
                           return true;
                           }).on('paste',function(ev){
                                 try{
                                 var selection = window.getSelection(),range = selection.getRangeAt(0),endContainer   = range.endContainer ,endOffset = range.endOffset ,startOffset    = range.startOffset ,startContainer = range.startContainer ;
                                 var fg = $('<p></p>'),removed = [];
                                 fg.html(ev.originalEvent.clipboardData.getData('text/plain'));
                                 while((removed = fg.find('font,span')).length){
                                 var first    = removed.first(),children = first[0].childNodes;
                                 first.replaceWith(children);
                                 }
                                 range.deleteContents();
                                 range.insertNode(fg[0]);
                                 selection.addRange(range);
                                 selection.collapseToEnd();
                                 removeNullTextNode(this);
                                 event.preventDefault();
                                 }catch(e){
                                 
                                 }
                                 })
    
    zss_editor.setPlaceholder('<p class="holder">请输入正文...</p>');
    $zss_editor_content.on('input', function(e){
                           zss_editor.calculateEditorHeightWithCaretPosition();
                           zss_editor.setScrollPosition();
                           zss_editor.enabledEditingItems();
                           });
    
    var _itv;
    var checkOffset = function(){
        if(_itv){
            clearTimeout(_itv);
        }
        _itv = setTimeout(function(){
                          zss_editor.updateOffset();
                          },1);
    }
    $(window).on('touchmove', function(e){
                 zss_editor.isDragging = true;
                 zss_editor.updateScrollOffset = true;
                 zss_editor.setScrollPosition();
                 checkOffset(e);
                 });
    $(window).on('touchstart', function(e){
                 zss_editor.isDragging = false;
                 });
    $(window).on('touchend', function(e){
                 checkOffset(e);
                 var $target = $(e.target);
                 if (!zss_editor.isDragging && !$target.is('input')){
                 setTimeout(function(){
                            zss_editor.focusEditor(e);
                            if($target.is('img') && !$(document.activeElement).is('div')){
                            var p =  $target.next(),editor = $zss_editor_content,range = document.createRange();
                            if(!p.length){
                            p = $target.parent();
                            }
                            if(p.length){
                            range.selectNodeContents(p[0]);
                            range.collapse(false);
                            var selection = window.getSelection();
                            selection.removeAllRanges();
                            selection.addRange(range);
                            editor.focus();
                            }
                            }
                            zss_editor.enabledEditingItems();
                            },0);
                 }
                 });
    var emptyHtml = '<p><br/></p>',html = $zss_editor_content.html(),focus_itv;
    if (!$.trim(html).length) {
        $zss_editor_content.html(emptyHtml);
    }
    $zss_editor_content.on('compositionstart',function(){
                           $(this).prop('comStart', true);
                           }).on('compositionend',function(){
                                 $(this).prop('comStart', false);
                                 }).on('input',function(ev){
                                       var $this = $(this);
                                       if(!$this.prop('comStart')){
                                       return false;
                                       }
                                       var node = zss_editor.getSelected(),html = $zss_editor_content.html();
                                       if(node && node.nodeName == "#text" && $(node.parentNode).is('.zss_editor_content')){
                                       document.execCommand('formatBlock', false, '<p>');
                                       }
                                       if(!$.trim(html).length){
                                       $zss_editor_content.html(emptyHtml);
                                       }
                                       }).on('focus',function(){
                                             if(focus_itv){
                                             clearTimeout(focus_itv);
                                             }
                                             focus_itv = setTimeout(function(){
                                                                    zss_editor.calculateEditorHeightWithCaretPosition();
                                                                    zss_editor.setScrollPosition();
                                                                    },200);
                                             })
    
    
    $('input').on('focus blur',function(ev){
                  var $target = $(ev.target);
                  switch(ev.type){
                  case 'focus':
                  window.location = "callback://20";
                  break;
                  case 'blur':
                  window.location = "callback://21";
                  break;
                  }
                  })
}//end

zss_editor.getSelected = function(){
    var node,selection;
    if (window.getSelection) {
        selection = getSelection();
        node = selection.anchorNode;
    }
    if (!node && document.selection) {
        selection = document.selection
        var range = selection.getRangeAt ? selection.getRangeAt(0) : selection.createRange();
        node = range.commonAncestorContainer ? range.commonAncestorContainer :
        range.parentElement ? range.parentElement() : range.item(0);
    }
    return node;
}


// This will show up in the XCode console as we are able to push this into an NSLog.
zss_editor.debug = function(msg) {
    window.location = 'debug://'+msg;
}


zss_editor.setScrollPosition = function() {
    var position = window.pageYOffset;
    window.location = 'scroll://'+position;
}


zss_editor.setPlaceholder = function(placeholder) {
    var editor = $zss_editor_content;
    if(editor.text().length <= 0){
        editor.html(placeholder).addClass('placeholder');
    }
    editor.on('keydown focus blur',function(ev){
              switch(ev.type){
              case 'keydown':
              case 'focus':
              if(editor.hasClass('placeholder')){
              editor.removeClass('placeholder').find('.holder').remove();
              if(!editor.text()){
              var selection = document.getSelection(),range = document.createRange(),$el = $('<p><br/></p>');
              editor.removeClass('placeholder').append($el);
              range.selectNodeContents($el[0]);
              selection.removeAllRanges();
              selection.addRange(range);
              }
              }
              break;
              case 'blur':
              var el = $('img',editor);
              if(!editor.text().length && !el.length){
              $(this).addClass('placeholder').html(placeholder);
              }
              break;
              }
              })
    
    
    
    var text = $(placeholder).text();
    editor.on('keydown',function(){
              if($(this).text() == text){
              var selection = document.getSelection(),range = document.createRange(),$el = $('<p><br/></p>');
              $(this).empty().removeClass('placeholder').append($el);
              range.selectNodeContents($el[0]);
              selection.removeAllRanges();
              selection.addRange(range);
              }
              }).focus(function(){
                       if($(this).text() == text){
                       var selection = document.getSelection(),range = document.createRange(),$el = $('<p><br/></p>');
                       $(this).empty().removeClass('placeholder').append($el);
                       range.selectNodeContents($el[0]);
                       selection.removeAllRanges();
                       selection.addRange(range);
                       }
                       })
    .focusout(function(){
              var img = $('img',$zss_editor_content);
              if(!$(this).text().length && img.length<=0){
              $(this).addClass('placeholder').html(placeholder);
              $(this).css("color","gray");
              }
              });
}


zss_editor.setFooterHeight = function(footerHeight) {
    $zss_editor_footer.css({
                           height : footerHeight
                           });
}

var $el = $('<p style="display:inline-block;visibility:hidden;width:0px;">1</p>');
zss_editor.getCaretYPosition = function() {
    var sel = window.getSelection(),range = sel.getRangeAt(0);
    range.collapse(false);
    range.insertNode($el[0]);
    var offset = $el.offset();
    $el.detach();
    return offset.top ;
}

var calculate_itv;
zss_editor.calculateEditorHeightWithCaretPosition = function() {
    var padding = 50;
    var c = zss_editor.getCaretYPosition();
    var e = document.getElementById('zss_editor_content');
    var offsetY = window.document.body.scrollTop;
    var height = zss_editor.getContentHeight();
    var newPos = window.pageYOffset;
    if(c < offsetY){
        newPos = c;
    } else if (c > (offsetY + height - padding)) {
        var newPos = c - height + padding - 5;
    }
    window.scrollTo(0, newPos);
}


zss_editor.updateOffset = function(ev) {
    if (!zss_editor.updateScrollOffset){
        return;
    }
    var $win = $(window),offsetY = $win.scrollTop(), maxOffsetY = $zss_editor_footer.offset().top - zss_editor.getContentHeight();
    if (maxOffsetY < 0){
        maxOffsetY = 0;
    }
    
    if (offsetY > maxOffsetY) {
        window.scrollTo(0, maxOffsetY+5);
    }
    zss_editor.setScrollPosition();
	 	 
}
zss_editor.backuprange = function(){
    var selection = window.getSelection();
    var range = selection.getRangeAt(0);
    zss_editor.currentSelection = {"startContainer": range.startContainer, "startOffset":range.startOffset,"endContainer":range.endContainer, "endOffset":range.endOffset};
}

zss_editor.restorerange = function(){
    var selection = window.getSelection();
    selection.removeAllRanges();
    var range = document.createRange();
    range.setStart(zss_editor.currentSelection.startContainer, zss_editor.currentSelection.startOffset);
    range.setEnd(zss_editor.currentSelection.endContainer, zss_editor.currentSelection.endOffset);
    selection.addRange(range);
}

zss_editor.getSelectedNode = function() {
    var node,selection;
    if (window.getSelection) {
        selection = getSelection();
        node = selection.anchorNode;
    }
    if (!node && document.selection) {
        selection = document.selection
        var range = selection.getRangeAt ? selection.getRangeAt(0) : selection.createRange();
        node = range.commonAncestorContainer ? range.commonAncestorContainer :
        range.parentElement ? range.parentElement() : range.item(0);
    }
    if (node) {
        return (node.nodeName == "#text" ? node.parentNode : node);
    }
};

zss_editor.setBold = function() {
    document.execCommand('bold', false, null);
    zss_editor.enabledEditingItems();
}

zss_editor.setItalic = function() {
    document.execCommand('italic', false, null);
    zss_editor.enabledEditingItems();
}

zss_editor.setSubscript = function() {
    document.execCommand('subscript', false, null);
    zss_editor.enabledEditingItems();
}

zss_editor.setSuperscript = function() {
    document.execCommand('superscript', false, null);
    zss_editor.enabledEditingItems();
}

zss_editor.setStrikeThrough = function() {
    document.execCommand('strikeThrough', false, null);
    zss_editor.enabledEditingItems();
}

zss_editor.setUnderline = function() {
    document.execCommand('underline', false, null);
    zss_editor.enabledEditingItems();
}

zss_editor.setBlockquote = function() {
    var current_selection = $(zss_editor.getSelectedNode()),blockquote = current_selection.closest('blockquote');
    if(blockquote.length){
        document.execCommand('formatBlock', false, '<p>');
    }else{
        document.execCommand('formatBlock', false, '<blockquote>');
    }
    zss_editor.enabledEditingItems();
    return false;
}

zss_editor.removeFormating = function() {
    document.execCommand('removeFormat', false, null);
    zss_editor.enabledEditingItems();
}

zss_editor.setHorizontalRule = function() {
    document.execCommand('insertHorizontalRule', false, null);
    zss_editor.enabledEditingItems();
}

zss_editor.setHeading = function(heading) {
    var current_selection = $(zss_editor.getSelectedNode());
    var t = current_selection.prop("tagName").toLowerCase();
    var is_heading = (t == 'h1' || t == 'h2' || t == 'h3' || t == 'h4' || t == 'h5' || t == 'h6');
    if (is_heading && heading == t) {
        var c = current_selection.html();
        current_selection.replaceWith(c);
    } else {
        document.execCommand('formatBlock', false, '<'+heading+'>');
    }
    zss_editor.enabledEditingItems();
}

zss_editor.setParagraph = function() {
    var current_selection = $(zss_editor.getSelectedNode());
    var t = current_selection.prop("tagName").toLowerCase();
    var is_paragraph = (t == 'p');
    if (is_paragraph) {
        var c = current_selection.html();
        current_selection.replaceWith(c);
    } else {
        document.execCommand('formatBlock', false, '<p>');
    }
    zss_editor.enabledEditingItems();
}


zss_editor.undo = function() {
    document.execCommand('undo', false, null);
    zss_editor.enabledEditingItems();
}

zss_editor.redo = function() {
    document.execCommand('redo', false, null);
    zss_editor.enabledEditingItems();
}

zss_editor.setOrderedList = function() {
    document.execCommand('insertOrderedList', false, null);
    zss_editor.enabledEditingItems();
}

zss_editor.setUnorderedList = function() {
    document.execCommand('insertUnorderedList', false, null);
    zss_editor.enabledEditingItems();
}

zss_editor.setJustifyCenter = function() {
    document.execCommand('justifyCenter', false, null);
    zss_editor.enabledEditingItems();
}

zss_editor.setJustifyFull = function() {
    document.execCommand('justifyFull', false, null);
    zss_editor.enabledEditingItems();
}

zss_editor.setJustifyLeft = function() {
    document.execCommand('justifyLeft', false, null);
    zss_editor.enabledEditingItems();
}

zss_editor.setJustifyRight = function() {
    document.execCommand('justifyRight', false, null);
    zss_editor.enabledEditingItems();
}

zss_editor.setIndent = function() {
    document.execCommand('indent', false, null);
    zss_editor.enabledEditingItems();
}

zss_editor.setOutdent = function() {
    document.execCommand('outdent', false, null);
    zss_editor.enabledEditingItems();
}

zss_editor.setTextColor = function(color) {
    zss_editor.restorerange();
    document.execCommand("styleWithCSS", null, true);
    document.execCommand('foreColor', false, color);
    document.execCommand("styleWithCSS", null, false);
    zss_editor.enabledEditingItems();
    // document.execCommand("removeFormat", false, "foreColor"); // Removes just foreColor
}

zss_editor.setBackgroundColor = function(color) {
    zss_editor.restorerange();
    document.execCommand("styleWithCSS", null, true);
    document.execCommand('hiliteColor', false, color);
    document.execCommand("styleWithCSS", null, false);
    zss_editor.enabledEditingItems();
}

// Needs addClass method

zss_editor.insertLink = function(url, title) {
    zss_editor.restorerange();
    $zss_editor_content.focus();
    if(!/^http:\/\//.test(url)){
       url = "http://" + url;
       }
       var html_code = '<a href="'+url+'" title="'+title+'">'+title+'</a>';
       zss_editor.insertHTML(html_code);
       zss_editor.enabledEditingItems();
       }
       
       zss_editor.updateLink = function(url, title) {
       zss_editor.restorerange();
       if (zss_editor.currentEditingLink) {
       var c = zss_editor.currentEditingLink;
       c.attr('href', url);
       c.attr('title', title);
       c.html(title);
       }
       zss_editor.enabledEditingItems();
       
       }//end
       
       zss_editor.updateImage = function(url, w,h,id) {
       zss_editor.restorerange();
       if (zss_editor.currentEditingImage) {
       var c = zss_editor.currentEditingImage;
       c.attr({
              src   : url,
              width : w,
              height: h,
              id    : id
              });
       }
       zss_editor.enabledEditingItems();
       
       }//end
       
       zss_editor.unlink = function() {
       if (zss_editor.currentEditingLink) {
       var c = zss_editor.currentEditingLink;
       c.contents().unwrap();
       }
       zss_editor.enabledEditingItems();
       }
       
       zss_editor.quickLink = function() {
       var sel = document.getSelection();
       var link_url = "";
       var test = new String(sel);
       var mailregexp = new RegExp("^(.+)(\@)(.+)$", "gi");
       if (test.search(mailregexp) == -1) {
       checkhttplink = new RegExp("^http\:\/\/", "gi");
       if (test.search(checkhttplink) == -1) {
       checkanchorlink = new RegExp("^\#", "gi");
       if (test.search(checkanchorlink) == -1) {
       link_url = "http://" + sel;
       } else {
       link_url = sel;
       }
       } else {
       link_url = sel;
       }
       } else {
       checkmaillink = new RegExp("^mailto\:", "gi");
       if (test.search(checkmaillink) == -1) {
       link_url = "mailto:" + sel;
       } else {
       link_url = sel;
       }
       }
       
       var html_code = '<a href="' + link_url + '">' + sel + '</a>';
       zss_editor.insertHTML(html_code);
       
       }
       
       zss_editor.prepareInsert = function() {
       zss_editor.backuprange();
       }
       
       zss_editor.insertImage = function(url,w,h,id) {
       zss_editor.restorerange();
       var html = '<p><img class="to-upload" src="'+url+'" id="'+id+'" /></p>';
       $(new Image).on('load',function(){
                       var $el = $('#'+id),w = $el.width(),h = $el.height(),pro = {width:w,height:h};
                       w && h && $el.css(pro) && $el.attr(pro);
                       setTimeout(function(){
                                  var offset = $el.offset();
                                  $(window).scrollTop(offset.top + h - $(window).innerHeight()+ 35);
                                  zss_editor.setScrollPosition();
                                  },300);
                       }).attr('src',url)
       $zss_editor_content.focus();
       zss_editor.insertHTML(html);
       zss_editor.enabledEditingItems();
       }
       
       
       zss_editor.insertHTML = function(html) {
       document.execCommand('insertHTML', false, html);
       zss_editor.enabledEditingItems();
       }
       
       $.extend(zss_editor,{
                foldEditor : function(){
                $zss_editor_footer.css({ height : 0 });
                },
                unfoldEditor : function(){
                
                },
                blurEditor : function(){
                $zss_editor_content.blur();
                },
                focusEditor : function(e){
                if($(e.target).is('body')){
                var editor = $zss_editor_content;
                var range = document.createRange();
                range.selectNodeContents(editor.get(0));
                range.collapse(false);
                var selection = window.getSelection();
                selection.removeAllRanges();
                selection.addRange(range);
                editor.focus();
                }
                },
                getHTML : function() {
                var img = $('img');
                if (img.length != 0) {
                img.removeClass('zs_active').each(function(index, e) {
                                                  var image = $(this);
                                                  var zs_class = image.attr('class');
                                                  if (typeof(zs_class) != "undefined") {
                                                  if (zs_class == '') {
                                                  image.removeAttr('class');
                                                  }
                                                  }
                                                  });
                }
                var bq = $('blockquote');
                if (bq.length != 0) {
                bq.each(function() {
                        var b = $(this);
                        if (b.css('border').indexOf('none') != -1) {
                        b.css({'border': ''});
                        }
                        if (b.css('padding').indexOf('0px') != -1) {
                        b.css({'padding': ''});
                        }
                        });
                }
                $zss_editor_content.removeClass('placeholder').find('.holder').remove();
                var h = document.getElementById("zss_editor_content").innerHTML;
                return h;
                },
                getText : function(){
                return $zss_editor_content.text();
                },
                getTitle : function(){
                return $.trim($('input.title').val());
                },
                getSubtitle : function(){
                return $.trim($('input.subtitle').val());
                },
                setHTML : function(html,title,subtile){
                if(title && title.length){
                $('.title').val(title);
                }
                if(subtile && subtile.length){
                $('.subtitle').val(title);
                }
                if(html){
                $zss_editor_content.html(html).removeClass('placeholder');
                $('img[data-src]',$zss_editor_content).attr('src',function(){
                                                            var real = $(this).attr('data-src');
                                                            $(this).removeAttr('data-src').removeAttr('style').removeAttr('width').removeAttr('height');
                                                            return real;
                                                            }).on('load',function(){
                                                                  var $this = $(this),w = $this.width(),h = $(this).height(),pro = {
                                                                  width : w,
                                                                  height: h
                                                                  };
                                                                  $this.attr(pro).css(pro);
                                                                  })
                } 
                },  
                setTitle: function(val){ 
                $('input.title').val(val);
                },
                setSubtitle: function(val){ 
                $('input.subtitle').val(val);
                },
                afterInsert : function(id,key,w,h){
                var src = 'http://news.artandus.com/'+key+'!n600.jpg'; 
                $(new Image).on('load',function(){ 
                                var $el = $('#'+id).attr('src',src).removeClass('to-upload'),w = $el.width(),h = $el.height();
                                $el.attr({
                                         width : w,
                                         height: h
                                         })
                                }).attr('src',src);
                }
                });
       
       zss_editor.isCommandEnabled = function(commandName) {
       return document.queryCommandState(commandName);
       } 
       zss_editor.enabledEditingItems = function(e) {
       var items = []; 
       if (zss_editor.isCommandEnabled('bold')) {
       items.push('bold'); 
       }
       var selection = window.getSelection();
       if (selection.rangeCount) {
       var range = selection.getRangeAt(0);
       var child = range.endContainer;
       }
       //$('.subtitle').val(child+' '+child.nodeName+ child.parenNode +' '+ child.parenNode.nodeName +' '+ $.now());
       
       if (zss_editor.isCommandEnabled('italic')) {
       items.push('italic');
       }
       if (zss_editor.isCommandEnabled('subscript')) {
       items.push('subscript');
       }
       if (zss_editor.isCommandEnabled('superscript')) {
       items.push('superscript');
       }
       if (zss_editor.isCommandEnabled('strikeThrough')) {
       items.push('strikeThrough');
       }
       if (zss_editor.isCommandEnabled('underline')) {
       items.push('underline');
       }
       if (zss_editor.isCommandEnabled('insertOrderedList')) {
       items.push('orderedList');
       }
       if (zss_editor.isCommandEnabled('insertUnorderedList')) {
       items.push('unorderedList');
       }
       if (zss_editor.isCommandEnabled('justifyCenter')) {
       items.push('justifyCenter');
       }
       if (zss_editor.isCommandEnabled('justifyFull')) {
       items.push('justifyFull');
       }
       if (zss_editor.isCommandEnabled('justifyLeft')) {
       items.push('justifyLeft');
       }
       if (zss_editor.isCommandEnabled('justifyRight')) {
       items.push('justifyRight');
       }
       if (zss_editor.isCommandEnabled('insertHorizontalRule')) {
       items.push('horizontalRule');
       }
       var formatBlock = document.queryCommandValue('formatBlock');
       if (formatBlock.length > 0) {
       items.push(formatBlock);
       }
       // Images 
       // Use jQuery to figure out those that are not supported
       if (typeof(e) != "undefined") { 
       // The target element
       var t = $(e.target);
       var nodeName = e.target.nodeName.toLowerCase();
       
       // Background Color
       var bgColor = t.css('backgroundColor');
       if (bgColor.length != 0 && bgColor != 'rgba(0, 0, 0, 0)' && bgColor != 'rgb(0, 0, 0)' && bgColor != 'transparent') {
       items.push('backgroundColor');
       }
       // Text Color
       var textColor = t.css('color');
       if (textColor.length != 0 && textColor != 'rgba(0, 0, 0, 0)' && textColor != 'rgb(0, 0, 0)' && textColor != 'transparent') {
       items.push('textColor');
       }
       // Link
       if (nodeName == 'a') {
       zss_editor.currentEditingLink = t;
       var title = t.attr('title');
       items.push('link:'+t.attr('href'));
       if (t.attr('title') !== undefined) {
       items.push('link-title:'+t.attr('title'));
       }
       
       } else {
       zss_editor.currentEditingLink = null;
       } 
       if (nodeName == 'blockquote') {
       items.push('indent');
       } 
       if (nodeName == 'img') {
       zss_editor.currentEditingImage = t;
       items.push('image:'+t.attr('src'));
       if (t.attr('alt') !== undefined) {
       items.push('image-alt:'+t.attr('alt'));
       } 
       } else {
       zss_editor.currentEditingImage = null;
       } 
       } 
       
       if (items.length > 0) {
       if (zss_editor.isUsingiOS) {
       
       window.location = "callback://0/"+items.join(',');
       } else {
       console.log("callback://"+items.join(','));
       }
       } else {
       if (zss_editor.isUsingiOS) {
       window.location = "zss-callback/";
       } else {
       console.log("callback://");
       }
       } 
       }
       
       $(function(){
         zss_editor.init();
         });