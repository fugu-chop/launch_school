1) Given the code below, what is the minimum width and height (in pixels) that the div needs to entirely contain the img element (including its margins)?
```html
<div>
  <img src="#" alt="test" />
</div>
```
```css
div {
  background-color: lightgray;
  border: 1px solid black;
  box-sizing: border-box;
  display: inline-block;
  margin: 0;
  padding: 0;
}

img {
  border: 4px solid red;
  box-sizing: content-box;
  display: inline-block;
  height: 300px;
  margin: 20px 19px 10px 11px;
  padding: 10px 20px;
  width: 500px;
}
```
Since the `img` has `display: inline-block`, we can compute the dimensions directly from the CSS properties. 

The `div` should be at least 580px wide and 360px tall in order to contain the `img` element including it's margins, due to the use of `border-box` (it will otherwise the `img` inside the `div` won't be fully displayed). While we don't typically count margins in determining an element's height and width, we need to include them here when calculating how much space we need in the `div`.

2) Given the code below, what is the minimum width and height (in pixels) that the div needs to entirely contain the section element (including its margins)?
```html
<div>
  <section>content</section>
</div>
```
```css
div {
  background-color: lightgray;
  border: 1px solid black;
  box-sizing: border-box;
  display: inline-block;
  margin: 0;
  padding: 0;
}

section {
  border: 4px solid red;
  box-sizing: content-box;
  display: block;
  height: 300px;
  margin: 20px 19px 10px 11px;
  padding: 10px 20px;
  width: 500px;
}
```
Since the section element is a `block` element, we can compute the dimensions directly from the CSS properties. 

Since the `div` uses `border-box` box-sizing, it must have a width and height of at least 580px and 360px, respectively. These values are identical to the answer from the previous practice problem. The chief difference is that other elements may appear adjacent to the `img` in problem 1, while the section in this problem will _always be on a line by itself_ within the `div` no matter its width.

3) Given the code below, what is the minimum width and height (in pixels) that the `div` needs to entirely contain the `em` element (including its margins)?
```html
<div>
  <em>content</em>
</div>
```
```css
div {
  background-color: lightgray;
  border: 1px solid black;
  box-sizing: border-box;
  display: inline-block;
  margin: 0;
  padding: 0;
}

em {
  border: 4px solid red;
  box-sizing: content-box;
  display: inline;
  height: 300px;
  margin: 20px 19px 10px 11px;
  padding: 10px 20px;
  width: 500px;
}
```
Since the `em` element is `inline`, the browser will ignore the width, height, and top and bottom margins specified in the CSS. For this reason, we cannot calculate the amount of space that any given `em` will take unless we know the actual width and height of the content.

If we assume that the `em` requires a 50px width, then the `div` element needs at least 130 pixels horizontally (including the `div` borders). If we assume that the `em` requires a 20px height, then the `div` needs at least 50 pixels vertically (again, including the `div` borders).

Keep in mind that the top and bottom padding and borders may intersect with content above and below the `em` element.

4) Given the code below, what is the minimum width and height (in pixels) that the `div` needs to be to entirely contain the `article` element (including its margins)?
```html
<div>
  <article>content</article>
</div>
```
```css
div {
  background-color: lightgray;
  border: 1px solid black;
  box-sizing: border-box;
  display: inline-block;
  margin: 0;
  padding: 0;
}

article {
  border: 4px solid red;
  box-sizing: border-box;
  display: inline-block;
  height: 300px;
  margin: 20px 19px 10px 11px;
  padding: 10px 20px;
  width: 500px;
}
```
Since the article is `inline-block`, we can compute the dimensions directly from the CSS properties. Since we also set the `box-sizing` property to `border-box`, we must ignore the padding and border to calculate the actual dimensions. The `div` element needs 532 pixels horizontally. The `div` needs 332 pixels vertically.

5) Given the code below, what element pairs will display side-by-side in the `<div>`? You may assume that any `inline` element has a content width of no more than 360 pixels. Remember, the `width` property doesn't affect `inline` elements, so this "content width" is the actual width of the content area as determined by your browser.
```
<div>
  <tag1>content</tag1><tag2>content</tag2>
</div>
```
```css
div {
  background-color: lightgray;
  border: 1px solid black;
  box-sizing: content-box;
  display: inline-block;
  margin: 0;
  padding: 0;
  width: 720px;
}

tag1, tag2 {
  box-sizing: border-box;
  height: 240px;
  margin: 0;
  padding: 0;
  width: 360px;
}

tag1 {
  background-color: yellow;
}

tag2 {
  background-color: lime;
}
```
`tag1` and `tag2` will display side by side if either are a combination of `inline` or `inline-block` elements. `block` elements will always take up an entire 'row' for themselves.

6) Will the following code display the two article boxes side-by-side? If not, why not? How would you fix it so that it places the boxes side-by-side?
```html
<section>
  <article>content</article><article>more content</article>
</section>
```
```css
section {
  background-color: yellow;
  border: 1px solid red;
  box-sizing: content-box;
  display: inline-block;
  height: 400px;
  margin: 0;
  padding: 20px;
  width: 900px;
}

article {
  background-color: lime;
  border: 1px solid blue;
  height: 100%;
  margin: 0;
  padding: 10px;
  width: 50%;
}
```
`article` elements are `block` elements by default. We could add a `display: inline-block` property to the `article` elements in the CSS file. However, the `article` element themselves won't fit neatly on a single line in our case, since the `article` elements take 50% of the available space, plus 20px of padding each. We thus need to add `box-sizing: border-box` so that the padding is applied on the 'inside' of the element

7) Given our solution to the previous question, what will happen if we put the `article` tags on separate lines?
```html
<section>
  <article>content</article>
  <article>more content</article>
</section>
```
When you put the `article` elements on separate lines in the HTML, the browser sees the whitespace (a newline and several spaces in this case) between the two articles. It then collapses that whitespace into a single space character and uses the result as content between the elements. Thus, the two articles require 900 pixels total plus a few more pixels to account for the space character. Since that exceeds the 900-pixel width of the `section`, the two `article` elements no longer fit on the same line.

This kind of problem often occurs when one of the elements is an `inline-block`; the rest of the time, the extra space typically doesn't matter. 
