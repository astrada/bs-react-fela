type styleObject('style) = Js.t(({..} as 'style));

type propsObject('props) = Js.t(({..} as 'props));

type rule('props, 'style) = propsObject('props) => styleObject('style);

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
    ~extend: propsObject('props) => Js.t({..})=?,
    ~props: propsObject('props),
    'children
  ) =>
  statelessComponent;

let createComponentWithProxy:
  (
    ~rule: rule('props, 'style),
    ~baseElement: baseElement=?,
    ~passThrough: array(string)=?,
    ~extend: propsObject('props) => Js.t({..})=?,
    ~props: propsObject('props),
    'children
  ) =>
  statelessComponent;

type themeObject('theme) = Js.t(({..} as 'theme));

type makeWithTheme('theme, 'children) =
  (~theme: themeObject('theme), 'children) => statelessComponent;

let withTheme:
  (~component: statelessComponent, ~make: makeWithTheme('theme, 'children), 'children) =>
  statelessComponent;

let connect:
  (
    ~rules: 'rules,
    ~component: statelessComponent,
    ~make: (~styles: Js.t(({..} as 'styles)), 'children) => statelessComponent,
    ~props: propsObject('props),
    'children
  ) =>
  statelessComponent;

module Provider: {
  type renderer;
  let defaultRenderer: renderer;
  let make: (~renderer: renderer=?, 'children) => statelessComponent;
};

module ThemeProvider: {
  let make:
    (~theme: themeObject('theme), ~overwrite: bool=?, ReasonReact.reactElement) =>
    statelessComponent;
};
