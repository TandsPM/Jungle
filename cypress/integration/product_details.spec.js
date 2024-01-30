describe('Product', () => {
  beforeEach(() => {
    cy.visit('/');
  });

  it('should bring us to the home page', () => {
    cy.get('.navbar-brand').should('have.text', 'Jungle');
  });

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

  it('should navigate to product page', () => {
    cy.get('.products article').first().click();
    cy.url().should('include', '/products/');
  });
});
