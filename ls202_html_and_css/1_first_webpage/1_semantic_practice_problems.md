# Practice Problems: Semantics

1. Which tags are semantic?
`<article>`, `<aside>`, `<footer>`, `<header>`, `<section>`, `<strong>`, `<h3>`, `<b>` are semantic tags, as they provide information about what role the element is supposed to play in the overall structure of the page. Note that `<b>` and `<i>` are now considered semantic - this was not the case in HTML4. `<div>` and `<span>` are _not_ semantic, as they are more for the organisation of different content, and used for styling purposes.

2. Which tag should replace `<sometag>` on this page?
```
<sometag>
  <h1>Lincoln's Gettysburg Address</h1>
  <p>
    Four score and seven years ago our fathers brought forth on this
    continent, a new nation, conceived in Liberty, and dedicated to the
    proposition that all men are created equal.
  </p>
  <p>
    Now we are engaged in a great civil war, testing whether that nation,
    or any nation so conceived and so dedicated, can long endure. We are
    met on a great battle-field of that war. We have come to dedicate a
    portion of that field, as a final resting place for those who here gave
    their lives that that nation might live. It is altogether fitting and
    proper that we should do this.
  </p>
  <p>
    But, in a larger sense, we can not dedicate—we can not consecrate—we
    can not hallow—this ground. The brave men, living and dead, who
    struggled here, have consecrated it, far above our poor power to add or
    detract. The world will little note, nor long remember what we say
    here, but it can never forget what they did here. It is for us the
    living, rather, to be dedicated here to the unfinished work which they
    who fought here have thus far so nobly advanced. It is rather for us
    to be here dedicated to the great task remaining before us—that from
    these honored dead we take increased devotion to that cause for which
    they gave the last full measure of devotion—that we here highly
    resolve that these dead shall not have died in vain—that this nation,
    under God, shall have a new birth of freedom—and that government of
    the people, by the people, for the people, shall not perish from the
    earth.
  </p>
</sometag>
```
The `<article>` tag might be most appropriate here, since the various paragraphs and headings serve to come together to form a cohesive piece of content that could be extracted and placed at another location on our site - it is self-contained and reusable.

3. Given the HTML from question 2, would it be appropriate to replace `<sometag>` with `<address>` or `<blockquote>`? If so, which one?
It's probably best to use `<blockquote>`, as the content is a fairly long piece of text with multiple tags within it, and represents a speech. `<address>` is intended to define contact information.

4. Which tag should replace `<sometag>` on this page?
```
<sometag>
  <h3>Text-align Property</h3>
  <p>
    Given the width of the paragraph, the heading looks odd hanging out on
    the left side of the screen. Let's center it instead; we'll do this
    with the text-align property:
  <p>

  <pre>
    <h1 style="color: orange; text-align: center;">Hello, Internet!</h1>
  </pre>
</sometag>
```
The `<section>` tag is probably most appropriate here. This is because the content itself doesn't represent a self-contained, stand-alone piece of content; it looks like it fits within a broader page about CSS properties.
