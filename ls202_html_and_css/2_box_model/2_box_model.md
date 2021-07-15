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

The `div` should be 580px wide and 360px tall in order to contain the `img` element including it's margins, due to the use of `border-box`. While we don't typically count margins in determining an element's height and width, we need to include them here when calculating how much space we need in the `div`.

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

If we assume that the `em` requires a 50px width, then the `div` element needs 130 pixels horizontally (including the `div` borders). If we assume that the `em` requires a 20px height, then the div needs 50 pixels vertically (again, including the `div` borders).

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
Since the article is `inline-block`, we can compute the dimensions directly from the CSS properties. Since we also set the box-sizing property to `border-box`, we must ignore the padding and border to calculate the actual dimensions. The `div` element needs 532 pixels horizontally. The `div` needs 332 pixels vertically.
