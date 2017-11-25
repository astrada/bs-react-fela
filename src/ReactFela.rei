type styleObject('style) = Js.t(({..} as 'style));

type rule('props, 'style) = Js.t(({..} as 'props)) => styleObject('style);

type statelessComponent =
  ReasonReact.component(
    ReasonReact.stateless,
    ReasonReact.noRetainedProps,
    ReasonReact.actionless
  );

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
  statelessComponent;

let createComponentWithProxy:
  (
    ~rule: rule('props, 'style),
    ~baseElement: baseElement=?,
    ~passThrough: array(string)=?,
    ~extend: Js.t('props) => Js.t({..})=?,
    Js.t('props),
    'children
  ) =>
  statelessComponent;

let withTheme:
  (statelessComponent, (~theme: Js.t({..}), 'children) => statelessComponent, 'children) =>
  statelessComponent;

let connect:
  (
    'rules,
    statelessComponent,
    (~styles: Js.t(({..} as 'styles)), 'children) => statelessComponent,
    Js.t(({..} as 'props)),
    'children
  ) =>
  statelessComponent;

module Provider: {
  type renderer;
  let defaultRenderer: renderer;
  let make: (~renderer: renderer=?, 'children) => statelessComponent;
};

module ThemeProvider: {
  type theme('theme) = Js.t(({..} as 'theme));
  let make:
    (~theme: theme('theme), ~overwrite: bool=?, ReasonReact.reactElement) => statelessComponent;
};
