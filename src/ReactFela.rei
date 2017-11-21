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

let createComponent:
  (
    ~rule: rule('props, 'style),
    ~baseElement: baseElement=?,
    ~passThrough: array(string)=?,
    ~extend: Js.t('props) => Js.t({..})=?,
    Js.t('props),
    'children
  ) =>
  ReasonReact.component(ReasonReact.stateless, ReasonReact.noRetainedProps, ReasonReact.actionless);

let createComponentWithProxy:
  (
    ~rule: rule('props, 'style),
    ~baseElement: baseElement=?,
    ~passThrough: array(string)=?,
    ~extend: Js.t('props) => Js.t({..})=?,
    Js.t('props),
    'children
  ) =>
  ReasonReact.component(ReasonReact.stateless, ReasonReact.noRetainedProps, ReasonReact.actionless);

module Provider: {
  type renderer;
  let defaultRenderer: renderer;
  let make:
    (~renderer: renderer=?, 'children) =>
    ReasonReact.component(
      ReasonReact.stateless,
      ReasonReact.noRetainedProps,
      ReasonReact.actionless
    );
};

module ThemeProvider: {
  type theme('theme) = Js.t(({..} as 'theme));
  let make:
    (~theme: theme('theme), 'children) =>
    ReasonReact.component(
      ReasonReact.stateless,
      ReasonReact.noRetainedProps,
      ReasonReact.actionless
    );
};
