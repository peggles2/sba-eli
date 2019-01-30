import React from "react";
import { shallow } from "enzyme";
import { Helmet } from "react-helmet";
import MetaTags from "../MetaTags";

describe("MetaTags", () => {
  it("should render a <Helmet> Tag", () => {
    const wrapper = shallow(<MetaTags />);
    expect(wrapper.find(Helmet).exists()).toBe(true);
  });

  it("should render default meta tags", () => {
    const wrapper = shallow(<MetaTags />);
    const helmetProps = wrapper.find(Helmet).props();

    expect(helmetProps.title.length).toBeGreaterThan(0);
    expect(helmetProps.title).toBe(
      "Small Business Administration: Women Entrepreneurs"
    );
    expect(helmetProps.meta[0].name).toBe("description");
    expect(helmetProps.meta[0].content).toBe(
      "We support America's small businesses. The SBA connects entrepreneurs with lenders and funding to help them plan, start and grow their business."
    );
  });

  it("should overwrite the default title tag", () => {
    var newTitle = "This is a title that wasn't there before";
    const wrapper = shallow(<MetaTags metaTitle={newTitle} />);
    const helmetProps = wrapper.find(Helmet).props();
    expect(helmetProps.title.length).toBeGreaterThan(0);
    expect(helmetProps.title).toBe(newTitle);
  });

  it("should overwrite the default description tag", () => {
    var newDescription = "this is a new and different description";
    const wrapper = shallow(<MetaTags metaDescription={newDescription} />);
    const helmetProps = wrapper.find(Helmet).props();

    expect(helmetProps.meta[0].name).toBe("description");
    expect(helmetProps.meta[0].content).toBe(newDescription);
  });

  it("should insert a canonical url", () => {
    var canonicalUrl = "https://sba.gov/eli/new_value";
    const wrapper = shallow(<MetaTags canonicalUrl={canonicalUrl} />);
    const helmetProps = wrapper.find(Helmet).props();

    expect(helmetProps.link[0].rel).toBe("canonical");
    expect(helmetProps.link[0].href).toBe(canonicalUrl);
  });

  it("should render default open graph tags", () => {
    const wrapper = shallow(<MetaTags />);

    const helmetProps = wrapper.find(Helmet).props();

    expect(helmetProps.meta[1].property).toBe("og:title");
    expect(helmetProps.meta[1].content).toBe(
      "Small Business Administration: Women Entrepreneurs"
    );

    expect(helmetProps.meta[2].property).toBe("og:description");
    expect(helmetProps.meta[2].content).toBe(
      "We support America's small businesses. The SBA connects entrepreneurs with lenders and funding to help them plan, start and grow their business."
    );

    expect(helmetProps.meta[3].property).toBe("og:type");
    expect(helmetProps.meta[3].content).toBe("website");

    expect(helmetProps.meta[4].property).toBe("og:image");
    expect(helmetProps.meta[4].content).toBe(
      "https://picsum.photos/200/300/?random"
    );

    expect(helmetProps.meta[5].property).toBe("og:url");
    expect(helmetProps.meta[5].content).toBe("https://sba.gov/eli");
  });

  it("should overwrite the default open graph title tag", () => {
    var newTitle = "This is a title that wasn't there before";
    const wrapper = shallow(<MetaTags metaTitle={newTitle} />);
    const helmetProps = wrapper.find(Helmet).props();

    expect(helmetProps.meta[1].property).toBe("og:title");
    expect(helmetProps.meta[1].content).toBe(newTitle);
  });

  it("should overwrite the default open graph description tag", () => {
    var newDescription = "this is a new and different description";
    const wrapper = shallow(<MetaTags metaDescription={newDescription} />);
    const helmetProps = wrapper.find(Helmet).props();

    expect(helmetProps.meta[2].property).toBe("og:description");
    expect(helmetProps.meta[2].content).toBe(newDescription);
  });

  it("should overwrite the default open graph image tag", () => {
    var newImageUrl = "https://picsum.photos/200";
    const wrapper = shallow(<MetaTags metaImage={newImageUrl} />);
    const helmetProps = wrapper.find(Helmet).props();
    expect(helmetProps.meta[4].property).toBe("og:image");
    expect(helmetProps.meta[4].content).toBe(newImageUrl);
  });

  it("should insert an open graph url", () => {
    var canonicalUrl = "https://sba.gov/eli/new_value";

    const wrapper = shallow(<MetaTags canonicalUrl={canonicalUrl} />);
    const helmetProps = wrapper.find(Helmet).props();
    expect(helmetProps.meta[5].property).toBe("og:url");
    expect(helmetProps.meta[5].content).toBe(canonicalUrl);
  });
});
