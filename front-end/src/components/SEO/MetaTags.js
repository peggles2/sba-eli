import React, { Component } from "react";
import { Helmet } from "react-helmet";

export default class MetaTags extends Component {
  getMetaTitle(pageTitle) {
    return pageTitle
      ? pageTitle
      : "Small Business Administration: Women Entrepreneurs";
  }

  getMetaDescription(description) {
    return description
      ? description
      : "We support America's small businesses. The SBA connects entrepreneurs with lenders and funding to help them plan, start and grow their business.";
  }

  getCanonicalUrl(url) {
    return url && url.startsWith("https://") ? url : "https://sba.gov/eli";
  }

  getMetaImage(imageUrl) {
    return imageUrl ? imageUrl : "https://picsum.photos/200/300/?random";
  }

  render() {
    const metaProps = [
      {
        name: "description",
        content: this.getMetaDescription(this.props.metaDescription)
      },
      {
        property: "og:title",
        content: this.getMetaTitle(this.props.metaTitle)
      },
      {
        property: "og:description",
        content: this.getMetaDescription(this.props.metaDescription)
      },
      {
        property: "og:type",
        content: "website"
      },
      {
        property: "og:image",
        content: this.getMetaImage(this.props.metaImage)
      },
      {
        property: "og:url",
        content: this.getCanonicalUrl(this.props.canonicalUrl)
      }
    ];

    const linkProp = {
      rel: "canonical",
      href: this.getCanonicalUrl(this.props.canonicalUrl)
    };
    return (
      <Helmet
        title={this.getMetaTitle(this.props.metaTitle)}
        meta={metaProps}
        link={linkProp}
      />
    );
  }
}
