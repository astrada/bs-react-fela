type styleObject('style) = Js.t(({..} as 'style));

type rule('props, 'style) = Js.t(({..} as 'props)) => styleObject('style);

type baseElement = [ | `String(string) | `ReactClass(ReasonReact.reactClass)];

[@bs.module "react-fela"]
external createReactClass : rule('props, 'style) => ReasonReact.reactClass =
  "createComponent";

[@bs.module "react-fela"]
external createReactClassWithBaseElement :
  (
    rule('props, 'style),
    [@bs.unwrap] [ | `String(string) | `ReactClass(ReasonReact.reactClass)]
  ) =>
  ReasonReact.reactClass =
  "createComponent";

[@bs.module "react-fela"]
external createReactClassWithBaseElementAndPassThroughProps :
  (
    rule('props, 'style),
    [@bs.unwrap] [ | `String(string) | `ReactClass(ReasonReact.reactClass)],
    array(string)
  ) =>
  ReasonReact.reactClass =
  "createComponent";

let createComponent = (~rule, ~baseElement=?, ~passThrough=?, ~extend=?, props, children) => {
  let reactClass =
    switch passThrough {
    | Some(pt) =>
      let be =
        switch baseElement {
        | Some(be) => be
        | None => `String("div")
        };
      createReactClassWithBaseElementAndPassThroughProps(rule, be, pt)
    | None =>
      switch baseElement {
      | Some(be) => createReactClassWithBaseElement(rule, be)
      | None => createReactClass(rule)
      }
    };
  let props =
    switch extend {
    | None => props
    | Some(f) => Js.Obj.assign(props, f(props))
    };
  ReasonReact.wrapJsForReason(~reactClass, ~props, children)
};

[@bs.module "react-fela"]
external createReactClassWithProxy : rule('props, 'style) => ReasonReact.reactClass =
  "createComponentWithProxy";

[@bs.module "react-fela"]
external createReactClassWithProxyAndBaseElement :
  (
    rule('props, 'style),
    [@bs.unwrap] [ | `String(string) | `ReactClass(ReasonReact.reactClass)]
  ) =>
  ReasonReact.reactClass =
  "createComponentWithProxy";

[@bs.module "react-fela"]
external createReactClassWithProxyBaseElementAndPassThroughProps :
  (
    rule('props, 'style),
    [@bs.unwrap] [ | `String(string) | `ReactClass(ReasonReact.reactClass)],
    array(string)
  ) =>
  ReasonReact.reactClass =
  "createComponentWithProxy";

let createComponentWithProxy = (~rule, ~baseElement=?, ~passThrough=?, ~extend=?, props, children) => {
  let reactClass =
    switch passThrough {
    | Some(pt) =>
      let be =
        switch baseElement {
        | Some(be) => be
        | None => `String("div")
        };
      createReactClassWithProxyBaseElementAndPassThroughProps(rule, be, pt)
    | None =>
      switch baseElement {
      | Some(be) => createReactClassWithProxyAndBaseElement(rule, be)
      | None => createReactClassWithProxy(rule)
      }
    };
  let props =
    switch extend {
    | None => props
    | Some(f) => Js.Obj.assign(props, f(props))
    };
  ReasonReact.wrapJsForReason(~reactClass, ~props, children)
};

module Provider = {
  type renderer;
  [@bs.module "react-fela"] external provider : ReasonReact.reactClass = "Provider";
  [@bs.module "fela"] external createRenderer : unit => renderer = "";
  let defaultRenderer = createRenderer();
  let make = (~renderer=defaultRenderer, children) =>
    ReasonReact.wrapJsForReason(~reactClass=provider, ~props={"renderer": renderer}, children);
};

module ThemeProvider = {
  type theme('theme) = Js.t(({..} as 'theme));
  [@bs.module "react-fela"] external reactClass : ReasonReact.reactClass = "ThemeProvider";
  let make = (~theme, children) =>
    ReasonReact.wrapJsForReason(~reactClass, ~props={"theme": theme}, children);
};
