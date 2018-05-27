<template>
  <form id="podlove-subscribe-test" method="post">
    <h2>Configuration</h2>

    <div>
      <input type="hidden" name="url" value="" />
      <input type="hidden" name="title" value="Podlove" />
      <input type="hidden" name="subtitle" value="Personal Media Development" />
      <input type="hidden" name="image" value="http://metaebene.me/podlove/files/2013/01/podlove-logo-1.2-600x600.png" />
    </div>

    <label for="uri-scheme">
      Please provide your
      <abbr title="Uniform Resource Identifier">URI</abbr> scheme / subscription
      <abbr title="Uniform Resource Locator">URL</abbr> prefix:
    </label>
    <input type="text" id="uri-scheme" placeholder="my-uri-scheme://" v-model="uriScheme" />

    <label>
      <input type="checkbox" id="perform_post_request" v-model="postRequest" /> Perform
      <code>POST</code> request
    </label>

    <h2>Test Links</h2>
    <p>
      Use the provided subscription URLs to test your URL-Scheme with your client. Please note that the https feed is currently
      secured by a self-signed certificate only so it might produce an error message.
    </p>

    <table>
      <thead>
        <tr>
          <th>URL</th>
          <th>Description</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(link, index) in this.urls" v-bind:key="index">
          <td>
            <a v-bind:href="linkUrl(link.scheme, link.host)" v-on:click="handleLinkClick">{{linkUrl(link.scheme, link.host)}}</a>
          </td>
          <th scope="row">{{link.desc}}</th>
        </tr>
      </tbody>
    </table>

    <h2>Bookmark</h2>
    <label for="bookmark-url">Use the provided link if you want to quickly check the behaviour on other devices.</label>
    <input type="url" v-bind:value="bookmarkUrl" id="bookmark-url" v-on:focus="selectContent" />
  </form>
</template>

<script>
const v4Host = "v4.http.feedtest.podlove.org/feed/mp3";
const v6Host = "v6.http.feedtest.podlove.org/feed/mp3";

let url = new URL(document.location.href);

let givenUrl = url.searchParams.get("uri");
let hasPost = url.searchParams.has("post");

export default {
  name: "app",
  data() {
    return {
      urls: [
        { desc: "no protocol included (IPv4 only)", scheme: "", host: v4Host },
        { desc: "with http protocol (IPv4 only)", scheme: "http://", host: v4Host },
        { desc: "with https protocol (IPv4 only)", scheme: "https://", host: v4Host },
        { desc: "no protocol included (IPv6 only)", scheme: "", host: v6Host },
        { desc: "with http protocol (IPv6 only)", scheme: "http://", host: v6Host },
        { desc: "with https protocol (IPv6 only)", scheme: "https://", host: v6Host }
      ],
      uriScheme: givenUrl || "",
      postRequest: hasPost
    };
  },

  computed: {
    bookmarkUrl: function() {
      if (!this.uriScheme) {
        return document.location.href;
      }

      let url = new URL(document.location.href);
      Array.from(url.searchParams.entries()).forEach(entry => url.searchParams.delete(entry[0]));

      url.searchParams.set("uri", this.uriScheme);
      if (this.postRequest) {
        url.searchParams.set("post", "");
      }

      return url.toString().replace(/=$/, "");
    }
  },

  methods: {
    selectContent(ev) {
      ev.target.setSelectionRange(0, ev.target.value.length);
    },

    linkUrl(protocol, host) {
      return `${this.uriScheme}${protocol}${host}`;
    },

    handleLinkClick(ev) {
      if (this.postRequest) {
        ev.preventDefault();

        const form = document.getElementById("podlove-subscribe-test");

        document.querySelector("input[name='url']").value = ev.target.href;
        form.setAttribute("action", this.uriScheme);
        form.submit();
      }
    }
  }
};
</script>
