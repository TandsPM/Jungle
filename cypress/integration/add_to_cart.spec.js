describe('Add to Cart', () => {
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

  it('should add item to cart when click add item', () => {
    cy.get('.btn-add-to-cart').first().click();
    cy.get('.cart-count').should('have.text', '1');
  });
});
