// From http://jsfiddle.net/ThinkingStiff/FSaU2/

function htmlEncode( html ) {
    return document.createElement( 'a' ).appendChild( 
        document.createTextNode( html ) ).parentNode.innerHTML;
};