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
            ? <link rel="canonical" href={url} />
            : ''
    }

    render() {
        return (
            <Helmet>
                <title>{this.getMetaTitle(this.props.metaTitle)}</title>
                <meta name="description" content={this.getMetaDescription(this.props.metaDescription)} />
                {this.getAuthor(this.props.metaAuthor)}
                {this.getCanonicalUrl(this.props.canonicalUrl)}
            </Helmet>
        )
    }
}