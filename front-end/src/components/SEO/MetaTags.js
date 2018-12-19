import React, {Component} from "react";
import {Helmet} from "react-helmet";

export default class MetaTags extends Component {

    getMetaTitle(pageTitle) {
        return pageTitle 
        ? pageTitle
        : "Small Business Administration: Women Entrepreneurs"
    }

    getMetaDescription(description) {
        return description
                    ? description
                    : "We support America's small businesses. The SBA connects entrepreneurs with lenders and funding to help them plan, start and grow their business."
    }

    getAuthor(authorName) {
        return authorName ? <meta name="author" content={authorName} /> : ''
    }

    getCanonicalUrl(url) {
        return (url && url.startsWith("https://"))
            ? url
            : 'https://sba.gov/eli'
    }

    getMetaImage(imageUrl) {
        return imageUrl
            ? imageUrl
            : 'https://picsum.photos/200/300/?random'
    }

    render() {
        return (
            <Helmet>
                <title>{this.getMetaTitle(this.props.metaTitle)}</title>
                <meta name="description" content={this.getMetaDescription(this.props.metaDescription)} />
                {this.getAuthor(this.props.metaAuthor)}
                <link rel="canonical" href={this.getCanonicalUrl(this.props.canonicalUrl)} />

                <meta property="og:title" content={this.getMetaTitle(this.props.metaTitle)} />
                <meta property="og:description" content={this.getMetaDescription(this.props.metaDescription)} />
                <meta property="og:type" content="website" />
                <meta property="og:image" content={this.getMetaImage(this.props.metaImage)} /> 
                <meta property="og:url" content={this.getCanonicalUrl(this.props.canonicalUrl)} />
            </Helmet>
        )
    }
}